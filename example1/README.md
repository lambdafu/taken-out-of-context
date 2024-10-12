If you run export-files.sh, it will create the docker container and run it to export:

- public and secret key files for Bob (bob.pk, bob.sk)
- an attacker-generated email using a Git commit signature by Bob (spoofed.eml)

The Git repository is in the container.

After importing and trusting Bob's key, Alice sees a valid signature in Thunderbird 115.5.0.

