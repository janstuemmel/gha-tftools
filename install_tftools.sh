#!/usr/bin/env bash
set -euo pipefail

TFENV_VERSION=${TFENV_VERSION:-2.2.2}
TGENV_VERSION=${TGENV_VERSION:-0.1.0}

GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
GITHUB_PATH=${GITHUB_PATH:-${GITHUB_WORKSPACE}/.github_path}

TFTOOLS_INSTALLDIR="${GITHUB_WORKSPACE}/.tftools"
TFTOOLS_BINDIR="${TFTOOLS_INSTALLDIR}/bin"
TFENV_INSTALLDIR="${TFTOOLS_INSTALLDIR}/tfenv"
TGENV_INSTALLDIR="${TFTOOLS_INSTALLDIR}/tgenv"

mkdir -p "${TFTOOLS_INSTALLDIR}"
mkdir -p "${TFTOOLS_BINDIR}"
mkdir -p "${TFENV_INSTALLDIR}"
mkdir -p "${TGENV_INSTALLDIR}"

###
### Install tfenv and link binaries
###
echo "Install tfenv ${TFENV_VERSION}"
curl -L "https://github.com/tfutils/tfenv/archive/v${TFENV_VERSION}.tar.gz" | tar -xz -C "${TFENV_INSTALLDIR}" --strip 1
echo 'trust-tfenv: yes' > "${TFENV_INSTALLDIR}/use-gpgv"

[ -e "${TFTOOLS_BINDIR}/terraform" ] || ln -s "${TFENV_INSTALLDIR}/bin/terraform" "${TFTOOLS_BINDIR}/terraform"
[ -e "${TFTOOLS_BINDIR}/tfenv" ] || ln -s  "${TFENV_INSTALLDIR}/bin/tfenv" "${TFTOOLS_BINDIR}/tfenv"

###
### Install latest terraform via tfenv and use it as default
###
echo "Install latest terraform"
"${TFTOOLS_BINDIR}/tfenv" install
"${TFTOOLS_BINDIR}/tfenv" use

###
### Install tgenv and link binaries
###
echo "Install tgenv ${TGENV_VERSION}"
curl -L "https://github.com/taosmountain/tgenv/archive/refs/tags/${TGENV_VERSION}.tar.gz" | tar -xz -C "${TGENV_INSTALLDIR}" --strip 1
echo 'trust-tfenv: yes' > "${TGENV_INSTALLDIR}/use-gpgv"

[ -e "${TFTOOLS_BINDIR}/terragrunt" ] || ln -s "${TGENV_INSTALLDIR}/bin/terragrunt" "${TFTOOLS_BINDIR}/terragrunt"
[ -e "${TFTOOLS_BINDIR}/tgenv" ] || ln -s "${TGENV_INSTALLDIR}/bin/tgenv" "${TFTOOLS_BINDIR}/tgenv"

###
### Install latest terragrunt via tgenv and use it as default
###
echo "Install latest terragrunt"
"${TFTOOLS_BINDIR}/tgenv" install
"${TFTOOLS_BINDIR}/tgenv" use

echo "${TFTOOLS_INSTALLDIR}/bin" >> "${GITHUB_PATH}"
