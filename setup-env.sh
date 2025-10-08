#!/bin/bash
set -e

echo "Setting up AWS credentials..."
# Run AWS setup and capture environment variables
AWS_OUTPUT=$(edctl aws shell -a Staging -r bedrock_inference -- printenv | grep -E 'AWS_ACCESS_KEY_ID|AWS_SECRET_ACCESS_KEY|AWS_SESSION_TOKEN')

echo "Setting up Claude configuration..."
# Run Claude setup and capture environment variables
CLAUDE_OUTPUT=$(edctl claude shell -- printenv | grep -E 'ANTHROPIC_MODEL')

# Create or overwrite .env file
# Anything prefixed with REACT_APP_ will be automatically picked up
cat > .env << EOF
# Auto-generated environment variables
# Generated on $(date)

# AWS Credentials
$(echo "$AWS_OUTPUT" | sed 's/^/REACT_APP_/')

# Claude Configuration
$(echo "$CLAUDE_OUTPUT" | sed 's/ANTHROPIC_MODEL=/REACT_APP_BEDROCK_INFERENCE_PROFILE_ID=/')
EOF
