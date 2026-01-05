# Simple Proposal Generator
# Helps AI create structured task proposals for queue replenishment

param(
    [string]$OutputDir = "$PSScriptRoot/queue-proposals"
)

$ErrorActionPreference = "Stop"
$timestamp = Get-Date -Format "yyyy-MM-dd"
$outputFile = Join-Path $OutputDir "$timestamp-proposals.md"

# Check if output directory exists
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    Write-Host "✅ Created proposals directory: $OutputDir" -ForegroundColor Green
}

# Check if file already exists
if (Test-Path $outputFile) {
    Write-Host "⚠️  Proposal file already exists: $outputFile" -ForegroundColor Yellow
    $continue = Read-Host "Append to existing file? (y/n)"
    if ($continue -ne "y") {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }
}

# Create or append to proposal file
$header = @"
# Task Proposals - $timestamp

**Generated**: $(Get-Date -Format "yyyy-MM-dd HH:mm")
**Context**: [AI: Describe current project state]
**Queue Health**: [AI: Check queue health status]

---

"@

if (-not (Test-Path $outputFile)) {
    $header | Out-File -FilePath $outputFile -Encoding UTF8
    Write-Host "✅ Created proposal file: $outputFile" -ForegroundColor Green
}

Write-Host ""
Write-Host "📝 Proposal Generator" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Proposal file: $outputFile" -ForegroundColor White
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. AI: Review status.md and tasks.md in this directory" -ForegroundColor White
Write-Host "2. AI: Generate 3-5 task proposals in the file above" -ForegroundColor White
Write-Host "3. AI: Use the template in queue-proposals/README.md" -ForegroundColor White
Write-Host "4. Human: Review proposals and approve/modify/reject" -ForegroundColor White
Write-Host "5. Human: Add approved tasks to tasks.md" -ForegroundColor White
Write-Host ""
Write-Host "💡 Tip: Good proposals include:" -ForegroundColor Cyan
Write-Host "   - Clear rationale tied to project needs" -ForegroundColor White
Write-Host "   - Realistic effort estimates" -ForegroundColor White
Write-Host "   - Appropriate priority levels" -ForegroundColor White
Write-Host "   - Identified dependencies and risks" -ForegroundColor White
Write-Host ""

# Open the file for editing (if running interactively)
if ($Host.UI.PromptForChoice) {
    $open = Read-Host "Open proposal file now? (y/n)"
    if ($open -eq "y") {
        if (Get-Command code -ErrorAction SilentlyContinue) {
            code $outputFile
        }
        elseif ($env:EDITOR) {
            & $env:EDITOR $outputFile
        }
        else {
            Start-Process notepad $outputFile
        }
    }
}

Write-Host "✅ Proposal template ready" -ForegroundColor Green
Write-Host ""
