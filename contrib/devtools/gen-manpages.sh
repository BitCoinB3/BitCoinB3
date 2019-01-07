#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINB3D=${BITCOINB3D:-$BINDIR/bitcoinb3d}
BITCOINB3CLI=${BITCOINB3CLI:-$BINDIR/bitcoinb3-cli}
BITCOINB3TX=${BITCOINB3TX:-$BINDIR/bitcoinb3-tx}
BITCOINB3QT=${BITCOINB3QT:-$BINDIR/qt/bitcoinb3-qt}

[ ! -x $BITCOINB3D ] && echo "$BITCOINB3D not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
B3CVER=($($BITCOINB3CLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoinb3d if --version-string is not set,
# but has different outcomes for bitcoinb3-qt and bitcoinb3-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINB3D --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINB3D $BITCOINB3CLI $BITCOINB3TX $BITCOINB3QT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${B3CVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${B3CVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
