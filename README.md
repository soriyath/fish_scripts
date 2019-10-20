# Fish scripts

Some Fish scripts to make my life easier

## check_ssl_certificates.fish

Checks if an SSL certificate is still valid.

### installation

Make a symbolic link in Fish's functions directory:
`ln -s <your repo>/check_ssl_certificate.fish ~/.config/fish/functions/`

### usage

run `check_ssl_certificate hostname port`
e.g. `check_ssl_certificate www.google.com 443`

this will yield `$status 0` if certificate is not expired<br />
or `$status 1` if there is an error
or `$status 2` if you forgot to give the hostname or port you want to check...

