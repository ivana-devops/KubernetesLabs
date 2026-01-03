# serve.ps1
# Unified entry point for Kubernetes Labs documentation (PowerShell Version).
# Supports both Live (Online) and Cockpit (Offline) modes.

$ErrorActionPreference = "Stop"

$REQS_FILE = "./mkdocs/requirements.txt"
$SITE_DIR = "./mkdocs-site"

Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "   Kubernetes Labs - Dual-Mode Control Center" -ForegroundColor Cyan
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "1) Live (Online)    - Real-time badges and GitHub integrations"
Write-Host "2) Cockpit (Offline) - Fast, local search, static assets"
Write-Host "--------------------------------------------------"
$MODE = Read-Host "Select Mode [1 or 2]"

if ($MODE -eq "1") {
    $CONFIG = "mkdocs-online.yml"
    $MODE_NAME = "LIVE (Online)"
}
else {
    $CONFIG = "mkdocs-offline.yml"
    $MODE_NAME = "COCKPIT (Offline-First)"
}

Write-Host "`nMode Selected: $MODE_NAME" -ForegroundColor Green

# Step 0.1: Virtual Environment Management
$VENV_DIR = ".venv"
if (-not (Test-Path $VENV_DIR)) {
    Write-Host "Creating virtual environment in $VENV_DIR..." -ForegroundColor Yellow
    python -m venv $VENV_DIR
}

Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& "$VENV_DIR\Scripts\Activate.ps1"

Write-Host "Step 1: Installing dependencies..." -ForegroundColor Yellow
python -m pip install -r $REQS_FILE

Write-Host "`nStep 2: Choosing Action..." -ForegroundColor Yellow
Write-Host "1) Serve (Interactive Dev Mode)"
Write-Host "2) Build (Generate Static Site)"
$ACTION = Read-Host "Select Action [1 or 2]"

if ($ACTION -eq "1") {
    Write-Host "Starting mkdocs serve using $CONFIG..." -ForegroundColor Cyan
    python -m mkdocs serve -f $CONFIG
}
else {
    Write-Host "Building documentation using $CONFIG..." -ForegroundColor Cyan
    python -m mkdocs build -f $CONFIG --strict
    
    Write-Host "`nStep 3: Starting local web server..." -ForegroundColor Yellow
    Write-Host "--------------------------------------------------"
    Write-Host "Docs will be available at: http://localhost:8080"
    Write-Host "Press Ctrl+C to stop the server."
    Write-Host "--------------------------------------------------"
    python -m http.server 8080 --directory $SITE_DIR
}
