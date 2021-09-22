#!/usr/bin/env bash
set -euo pipefail

export AWS_WEB_IDENTITY_TOKEN_FILE=${AWS_WEB_IDENTITY_TOKEN_FILE:-"/tmp/awscreds"}
export AWS_ROLE_ARN=${AWS_ROLE_ARN:-""}
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-"eu-central-1"}
export GITHUB_ENV=${GITHUB_ENV:-.github_env}
export ACTIONS_ID_TOKEN_REQUEST_TOKEN=${ACTIONS_ID_TOKEN_REQUEST_TOKEN:-"not-specified"}
export ACTIONS_ID_TOKEN_REQUEST_URL=${ACTIONS_ID_TOKEN_REQUEST_URL:-"not-specified"}

if [ -n "${AWS_ROLE_ARN}" ]; then
  echo "Creating token for role ${AWS_ROLE_ARN}"
  echo "AWS_WEB_IDENTITY_TOKEN_FILE=${AWS_WEB_IDENTITY_TOKEN_FILE}" >> "${GITHUB_ENV}"
  echo "AWS_ROLE_ARN=${AWS_ROLE_ARN}" >> "${GITHUB_ENV}"
  echo "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}" >> "${GITHUB_ENV}"
  curl -H "Authorization: bearer ${ACTIONS_ID_TOKEN_REQUEST_TOKEN}" "${ACTIONS_ID_TOKEN_REQUEST_URL}" \
    | jq -r '.value' > "${AWS_WEB_IDENTITY_TOKEN_FILE}"
else
  echo "Role not set - no need to create token"
fi
