# Simple Queue Health Checker
# Analyzes tasks.md and reports queue health status

param(
    [string]$TasksFile = "$PSScriptRoot/tasks.md",
    [switch]$Detailed = $false
)

$ErrorActionPreference = "Stop"

# Check if tasks file exists
if (-not (Test-Path $TasksFile)) {
    Write-Host "❌ Error: Tasks file not found at $TasksFile" -ForegroundColor Red
    Write-Host "   Make sure you're running this from the project root." -ForegroundColor Yellow
    exit 1
}

# Read tasks file
$content = Get-Content $TasksFile -Raw

# Count tasks by priority (looking for unchecked items: - [ ])
$criticalCount = ([regex]::Matches($content, '(?m)^## 🔥.*?(?=^##|\z)', [System.Text.RegularExpressions.RegexOptions]::Singleline) | ForEach-Object {
    ([regex]::Matches($_.Value, '- \[ \]')).Count
}) | Measure-Object -Sum | Select-Object -ExpandProperty Sum

$highCount = ([regex]::Matches($content, '(?m)^## ⚡.*?(?=^##|\z)', [System.Text.RegularExpressions.RegexOptions]::Singleline) | ForEach-Object {
    ([regex]::Matches($_.Value, '- \[ \]')).Count
}) | Measure-Object -Sum | Select-Object -ExpandProperty Sum

$mediumCount = ([regex]::Matches($content, '(?m)^## 📋.*?(?=^##|\z)', [System.Text.RegularExpressions.RegexOptions]::Singleline) | ForEach-Object {
    ([regex]::Matches($_.Value, '- \[ \]')).Count
}) | Measure-Object -Sum | Select-Object -ExpandProperty Sum

$lowCount = ([regex]::Matches($content, '(?m)^## 💭.*?(?=^##|\z)', [System.Text.RegularExpressions.RegexOptions]::Singleline) | ForEach-Object {
    ([regex]::Matches($_.Value, '- \[ \]')).Count
}) | Measure-Object -Sum | Select-Object -ExpandProperty Sum

$totalCount = $criticalCount + $highCount + $mediumCount + $lowCount

# Determine health status
$health = if ($totalCount -eq 0) { "DEPLETED" }
          elseif ($totalCount -le 3) { "CRITICAL" }
          elseif ($totalCount -le 6) { "LOW" }
          else { "HEALTHY" }

# Determine health color
$healthColor = switch ($health) {
    "HEALTHY" { "Green" }
    "LOW" { "Yellow" }
    "CRITICAL" { "Red" }
    "DEPLETED" { "Red" }
}

# Check individual thresholds
$criticalStatus = if ($criticalCount -ge 1) { "✅" } else { "⚠️" }
$highStatus = if ($highCount -ge 2) { "✅" } else { "⚠️" }
$mediumStatus = if ($mediumCount -ge 3) { "✅" } else { "⚠️" }
$lowStatus = if ($lowCount -ge 5) { "✅" } else { "⚠️" }

# Display results
Write-Host ""
Write-Host "📊 Queue Health Check" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Overall Status: " -NoNewline
Write-Host $health -ForegroundColor $healthColor
Write-Host ""

if ($Detailed) {
    Write-Host "Priority Breakdown:" -ForegroundColor White
    Write-Host "-------------------" -ForegroundColor White
    Write-Host "🔥 Critical: $criticalCount tasks (threshold: ≥1) $criticalStatus"
    Write-Host "⚡ High:     $highCount tasks (threshold: ≥2) $highStatus"
    Write-Host "📋 Medium:   $mediumCount tasks (threshold: ≥3) $mediumStatus"
    Write-Host "💭 Low:      $lowCount tasks (threshold: ≥5) $lowStatus"
    Write-Host ""
    Write-Host "Total: $totalCount actionable tasks (target: ≥7)" -ForegroundColor White
    Write-Host ""
}

# Provide recommendations
if ($health -eq "DEPLETED") {
    Write-Host "⚠️  URGENT: Queue is empty!" -ForegroundColor Red
    Write-Host "   Action: Generate task proposals immediately" -ForegroundColor Yellow
    Write-Host "   Command: pwsh $PSScriptRoot/propose-tasks.ps1" -ForegroundColor Yellow
}
elseif ($health -eq "CRITICAL") {
    Write-Host "⚠️  WARNING: Queue is critically low" -ForegroundColor Red
    Write-Host "   Action: Generate task proposals soon" -ForegroundColor Yellow
    Write-Host "   Recommendation: Review and add 5-10 new tasks" -ForegroundColor Yellow
}
elseif ($health -eq "LOW") {
    Write-Host "💡 NOTICE: Queue is getting low" -ForegroundColor Yellow
    Write-Host "   Action: Consider generating task proposals" -ForegroundColor White
    Write-Host "   Recommendation: Add 3-5 new tasks to maintain flow" -ForegroundColor White
}
else {
    Write-Host "✅ Queue is healthy!" -ForegroundColor Green
    Write-Host "   Continue with current priorities" -ForegroundColor White
}

Write-Host ""

# Return appropriate exit code
if ($health -eq "DEPLETED" -or $health -eq "CRITICAL") {
    exit 1
}
else {
    exit 0
}
