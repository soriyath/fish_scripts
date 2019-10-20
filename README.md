# Fish scripts

Some Fish scripts to make my life easier

## check_ssl_certificates.fish

Checks if an SSL certificate is still valid.

### installation

Copy file `check_ssl_certificate.fish` into `~/.config/fish/functions/`

### usage

run `check_ssl_certificate hostname:port`

this will yield `$status 0` if certificate is not expired<br />
or `$status 1` if there is an error
