[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$ProjectRoot
)

$ErrorActionPreference = 'Stop'

function Ensure-Directory {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
    }
}

function Ensure-File {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        $parent = Split-Path -Parent $Path
        if ($parent) {
            Ensure-Directory -Path $parent
        }
        New-Item -ItemType File -Force -Path $Path | Out-Null
    }
}

function Ensure-LineInFile {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][string]$Line
    )

    Ensure-File -Path $FilePath

    $content = Get-Content -LiteralPath $FilePath -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) { $content = '' }

    if ($content -notmatch "(?m)^\s*${([Regex]::Escape($Line))}\s*$") {
        if ($content.Length -gt 0 -and $content[-1] -ne "`n") {
            Add-Content -LiteralPath $FilePath -Value ""
        }
        Add-Content -LiteralPath $FilePath -Value $Line
    }
}

function Try-ParseOptionAFromSnippet {
    param([Parameter(Mandatory = $true)][string]$SnippetPath)

    if (-not (Test-Path -LiteralPath $SnippetPath)) {
        return $null
    }

    $raw = Get-Content -LiteralPath $SnippetPath -Raw

    $optionA = $null
    $stop = $null

    $optionAMatch = [regex]::Match(
        $raw,
        '## Option A[^\n]*\n\s*```markdown\s*(?<body>[\s\S]*?)\s*```',
        [System.Text.RegularExpressions.RegexOptions]::Multiline
    )

    if ($optionAMatch.Success) {
        $optionA = $optionAMatch.Groups['body'].Value.Trim()
    }

    $stopMatch = [regex]::Match(
        $raw,
        'Optional.*?\n\s*```markdown\s*(?<body>[\s\S]*?)\s*```',
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    if ($stopMatch.Success) {
        $stop = $stopMatch.Groups['body'].Value.Trim()
    }

    # Keep the toolkit's canonical scratch directory name.

    return @{
        OptionA = $optionA
        StopCondition = $stop
    }
}

function Ensure-AdtBlockInCopilotInstructions {
    param(
        [Parameter(Mandatory = $true)][string]$CopilotInstructionsPath,
        [Parameter(Mandatory = $true)][string]$OptionABlock,
        [Parameter(Mandatory = $true)][string]$StopConditionBlock
    )

    Ensure-File -Path $CopilotInstructionsPath

    $content = Get-Content -LiteralPath $CopilotInstructionsPath -Raw

    $startMarker = '<!-- ADT v4 BOOTSTRAP START -->'
    $endMarker = '<!-- ADT v4 BOOTSTRAP END -->'

    if ($content -match [Regex]::Escape($startMarker) -and $content -match [Regex]::Escape($endMarker)) {
        return
    }

    $alreadyHasAdt = ($content -match "(?i)ADT v4\s*\(Required\)" -or $content -match "\.adt/INSTRUCTIONS\.md")

    if (-not $alreadyHasAdt) {
        $block = @(
            $startMarker,
            '',
            $OptionABlock,
            '',
            $StopConditionBlock,
            '',
            $endMarker,
            ''
        ) -join "`n"

        Set-Content -LiteralPath $CopilotInstructionsPath -Value ($block + $content) -Encoding UTF8
        return
    }

    $hasStop = $content -match "(?i)Stop Condition"
    if (-not $hasStop) {
        $append = @(
            '',
            $startMarker,
            '',
            $StopConditionBlock,
            '',
            $endMarker,
            ''
        ) -join "`n"

        Add-Content -LiteralPath $CopilotInstructionsPath -Value $append
    }
}

$toolkitRoot = Split-Path -Parent $PSScriptRoot

if (-not $ProjectRoot) {
    $ProjectRoot = Split-Path -Parent $toolkitRoot
}

$ProjectRoot = (Resolve-Path -LiteralPath $ProjectRoot).Path
$toolkitRoot = (Resolve-Path -LiteralPath $toolkitRoot).Path

Write-Host "ADT init: project root = $ProjectRoot"
Write-Host "ADT init: toolkit root = $toolkitRoot"

$contextDir = Join-Path $ProjectRoot '.adt-context'
$templateDir = Join-Path $toolkitRoot 'context-template'

Ensure-Directory -Path $contextDir

if (Test-Path -LiteralPath $templateDir) {
    Get-ChildItem -LiteralPath $templateDir | ForEach-Object {
        $dest = Join-Path $contextDir $_.Name
        if (-not (Test-Path -LiteralPath $dest)) {
            Copy-Item -LiteralPath $_.FullName -Destination $dest -Recurse -Force
        }
    }
}

Ensure-Directory -Path (Join-Path $ProjectRoot '.scratchpad')
Ensure-Directory -Path (Join-Path $ProjectRoot '.github')

$gitignorePath = Join-Path $ProjectRoot '.gitignore'
Ensure-File -Path $gitignorePath
Ensure-LineInFile -FilePath $gitignorePath -Line '.scratchpad/'

$snippetPath = Join-Path $toolkitRoot 'COPILOT-INSTRUCTIONS-SNIPPET.md'
$parsed = Try-ParseOptionAFromSnippet -SnippetPath $snippetPath

$optionA = $parsed.OptionA
$stopCondition = $parsed.StopCondition

if (-not $optionA) {
    $optionA = @(
        '> **ADT v4 (Required)**:',
        '> 1) Before making changes, read `.adt/INSTRUCTIONS.md`.',
        '> 2) Treat `.adt-context/` as the project''s committed memory and read it first.',
        '> 3) Check `.adt-context/interrupt.md` at checkpoints; if it contains instructions, stop and ask.',
        '> 4) Log repeated command failures in `.adt-context/attempts.md` and don''t repeat the same command without changing something.',
        '> 5) Put temporary scripts/debug helpers in `.scratchpad/` (gitignored).'
    ) -join "`n"
}

if (-not $stopCondition) {
    $stopCondition = '> **Stop Condition**: If you have not read `.adt-context/now.md`, stop and read it before proceeding.'
}

$copilotInstructionsPath = Join-Path (Join-Path $ProjectRoot '.github') 'copilot-instructions.md'
Ensure-AdtBlockInCopilotInstructions -CopilotInstructionsPath $copilotInstructionsPath -OptionABlock $optionA -StopConditionBlock $stopCondition

$oldAdtPath = Join-Path $ProjectRoot '.old-adt'
$migrationRequired = Test-Path -LiteralPath $oldAdtPath

$statePath = Join-Path $contextDir 'adt-state.json'
$state = $null
if (Test-Path -LiteralPath $statePath) {
    try {
        $state = Get-Content -LiteralPath $statePath -Raw | ConvertFrom-Json
    } catch {
        $state = $null
    }
}

if (-not $state) {
    $state = [pscustomobject]@{}
}

$now = (Get-Date).ToUniversalTime().ToString('o')

$state | Add-Member -Force -NotePropertyName 'toolkitVersion' -NotePropertyValue 'v4'
$state | Add-Member -Force -NotePropertyName 'bootstrapCompleted' -NotePropertyValue $true
$state | Add-Member -Force -NotePropertyName 'lastBootstrapAt' -NotePropertyValue $now
$state | Add-Member -Force -NotePropertyName 'contextReadmeCustomized' -NotePropertyValue ($state.contextReadmeCustomized -eq $true)

if (-not $state.migration) {
    $detectedAt = $null
    if ($migrationRequired) {
        $detectedAt = $now
    }

    $state | Add-Member -Force -NotePropertyName 'migration' -NotePropertyValue ([pscustomobject]@{
        required = $migrationRequired
        completed = $false
        detectedAt = $detectedAt
    })
} else {
    $state.migration.required = $migrationRequired
    if ($migrationRequired -and -not $state.migration.detectedAt) {
        $state.migration.detectedAt = $now
    }
}

$state | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $statePath -Encoding UTF8

if ($migrationRequired) {
    $migrationNotePath = Join-Path $contextDir 'migration-needed.md'
    if (-not (Test-Path -LiteralPath $migrationNotePath)) {
        @(
            '# Migration Needed',
            '',
            'Detected `.old-adt/` at repo root. This usually means an ADT v3 -> v4 migration is pending.',
            '',
            'Follow the guide in `.adt/ADT-V3-TO-V4-MIGRATION.md` (focus on Step 4: migrate real content into `.adt-context/`).',
            '',
            'When done, set `migration.completed` to `true` in `adt-state.json`.'
        ) | Set-Content -LiteralPath $migrationNotePath -Encoding UTF8
    }
}

Write-Host 'ADT init complete.'
