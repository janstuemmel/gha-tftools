#!/usr/bin/env bash
set -euxo pipefail

mkdir -p "${TFTOOLS_INSTALLDIR}"

TFTOOLS_BINDIR="${TFTOOLS_INSTALLDIR}/bin"
mkdir -p "${TFTOOLS_BINDIR}"

TFENV_INSTALLDIR="${TFTOOLS_INSTALLDIR}/tfenv"
mkdir -p "${TFENV_INSTALLDIR}"

curl -L "https://github.com/tfutils/tfenv/archive/v${TFENV_VERSION}.tar.gz" | tar -xvz -C "${TFENV_INSTALLDIR}" --strip 1
echo 'trust-tfenv: yes' > "${TFENV_INSTALLDIR}/use-gpgv"

ln -s ../tfenv/bin/terraform "${TFTOOLS_BINDIR}/terraform"
ln -s ../tfenv/bin/tfenv "${TFTOOLS_BINDIR}/tfenv"

"${TFTOOLS_BINDIR}/tfenv" install
"${TFTOOLS_BINDIR}/tfenv" use
