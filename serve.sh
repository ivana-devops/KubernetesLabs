#!/bin/bash

# serve.sh
# Unified entry point for Kubernetes Labs documentation.
# Supports both Live (Online) and Cockpit (Offline) modes.

set -e

REQS_FILE="./mkdocs/requirements.txt"
SITE_DIR="./mkdocs-site"

# Detect Python command
echo "Step 0: Checking environment..."
PY_CMD=""
# Prioritize 'python' as requested by the environment check
for cmd in "python" "python3" "py"; do
    if command -v "$cmd" > /dev/null 2>&1; then
        echo "Found '$cmd' executable. Verifying pip..."
        if "$cmd" -m pip --version > /dev/null 2>&1; then
            PY_CMD="$cmd"
            echo "Success! Using '$PY_CMD' with pip."
            break
        else
            echo "   [!] '$cmd' found but has no pip module. Skipping..."
        fi
    fi
done

if [ -z "$PY_CMD" ]; then
    echo "--------------------------------------------------"
    echo "ERROR: No working Python with pip found."
    echo "Current PATH includes: $(command -v python || echo 'none'), $(command -v python3 || echo 'none')"
    echo "Please ensure 'python -m pip' works in this terminal."
    echo "--------------------------------------------------"
    exit 1
fi

set -e

# Step 0.1: Virtual Environment Management
VENV_DIR=".venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment in $VENV_DIR..."
    $PY_CMD -m venv "$VENV_DIR"
fi

echo "Activating virtual environment..."
if [ -f "$VENV_DIR/Scripts/activate" ]; then
    source "$VENV_DIR/Scripts/activate"
elif [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
else
    echo "Error: Could not find activation script in $VENV_DIR"
    exit 1
fi

echo "--------------------------------------------------"
echo "   Kubernetes Labs - Dual-Mode Control Center"
echo "--------------------------------------------------"
echo "1) Live (Online)  - Real-time badges and GitHub integrations"
echo "2) Cockpit (Offline) - Fast, local search, static assets"
echo "--------------------------------------------------"
read -p "Select Mode [1 or 2]: " MODE

if [ "$MODE" == "1" ]; then
    CONFIG="mkdocs-online.yml"
    MODE_NAME="LIVE (Online)"
else
    CONFIG="mkdocs-offline.yml"
    MODE_NAME="COCKPIT (Offline-First)"
fi

echo ""
echo "Mode Selected: $MODE_NAME (Environment: $VENV_DIR)"
echo "Step 1: Installing dependencies..."
python -m pip install -r "$REQS_FILE"

echo "Step 2: Choosing Action..."
echo "1) Serve (Interactive Dev Mode)"
echo "2) Build (Generate Static Site)"
read -p "Select Action [1 or 2]: " ACTION

if [ "$ACTION" == "1" ]; then
    echo "Starting mkdocs serve using $CONFIG..."
    python -m mkdocs serve -f "$CONFIG"
else
    echo "Building documentation using $CONFIG..."
    python -m mkdocs build -f "$CONFIG" --strict
    
    echo ""
    echo "Step 3: Starting local web server..."
    echo "--------------------------------------------------"
    echo "Docs will be available at: http://localhost:8080"
    echo "Press Ctrl+C to stop the server."
    echo "--------------------------------------------------"
    python -m http.server 8080 --directory "$SITE_DIR"
fi
