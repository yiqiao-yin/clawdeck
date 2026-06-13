#!/bin/bash
# Clawdeck Terminal welcome message - shown on each new session

# Green terminal colors
export TERM=xterm-256color

cat << 'BANNER'

 ██╗    ██╗██╗   ██╗███╗   ██╗██████╗  ██████╗  ██████╗
 ██║    ██║╚██╗ ██╔╝████╗  ██║╚════██╗██╔════╝ ██╔═████╗
 ██║ █╗ ██║ ╚████╔╝ ██╔██╗ ██║ █████╔╝███████╗ ██║██╔██║
 ██║███╗██║  ╚██╔╝  ██║╚██╗██║ ╚═══██╗██╔═══██╗████╔╝██║
 ╚███╔███╔╝   ██║   ██║ ╚████║██████╔╝╚██████╔╝╚██████╔╝
  ╚══╝╚══╝    ╚═╝   ╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚═════╝

  Clawdeck Web Terminal
  -------------------

BANNER

echo "  Welcome! This is a live terminal with clawdeck pre-installed."
echo ""
echo "  QUICK START:"
echo "  ─────────────────────────────────────────────────────────"
echo "  1. Set your API key:"
echo ""
echo "     export ANTHROPIC_API_KEY=sk-ant-your-key-here"
echo ""
echo "  2. Launch the assistant:"
echo ""
echo "     clawdeck"
echo ""
echo "  OTHER PROVIDERS:"
echo "  ─────────────────────────────────────────────────────────"
echo "  Google Gemini:  export GEMINI_API_KEY=your-key"
echo "                  export CHOOSE_CLIENT=3"
echo ""
echo "  OpenAI:         export OPENAI_API_KEY=sk-your-key"
echo "                  export CHOOSE_CLIENT=4"
echo ""
echo "  AWS Bedrock:    export AWS_ACCESS_KEY_ID=your-id"
echo "                  export AWS_SECRET_ACCESS_KEY=your-secret"
echo "                  export CHOOSE_CLIENT=2"
echo ""
echo "  ─────────────────────────────────────────────────────────"
echo "  Type 'clawdeck --help' for all options."
echo ""
