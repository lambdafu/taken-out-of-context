FROM ubuntu

RUN apt update && apt install -y gnupg git
RUN echo "" | gpg --passphrase-fd 0 --pinentry-mode loopback --batch --quick-generate-key "Alice <alice@example.com>"
RUN echo "" | gpg --passphrase-fd 0 --pinentry-mode loopback --batch --quick-generate-key "Bob <bob@example.com>"
COPY generate-files.sh /
RUN /generate-files.sh


