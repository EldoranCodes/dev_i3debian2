#!/usr/bin/env bash
# ================================================
# Module 01: Update Package Manager
# ================================================

set -e

echo -e "\033[0;35m[01/05]\033[0m Updating package manager..."

$SUDO apt update -qq

echo -e "\033[0;32m[OK]\033[0m Package lists updated"
