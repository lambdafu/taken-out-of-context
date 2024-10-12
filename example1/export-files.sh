docker build -t context .
docker run -ti --rm context gpg --armor --export alice@example.com > alice.pk
docker run -ti --rm context gpg --armor --export-secret-keys alice@example.com > alice.sk
docker run -ti --rm context gpg --armor --export bob@example.com > bob.pk
docker run -ti --rm context gpg --armor --export-secret-keys bob@example.com > bob.sk
docker run -ti --rm context cat /tmp/spoofed.eml > spoofed.eml
