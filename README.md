# Fish scripts

Some Fish scripts to make my life easier

## check_ssl_certificates.fish

Checks if an SSL certificate is still valid.

### installation

Make a symbolic link in Fish's functions directory:
`ln -s <your repo>/check_ssl_certificate.fish ~/.config/fish/functions/`

### usage

run `check_ssl_certificate -u hostname -v`
e.g. `check_ssl_certificate -u www.google.com -v`

run `check_ssl_certificate -h` to check all the options
and `check_ssl_certificate -c` to check return codes.

this will yield `$status 0` if certificate is not expired<br />
or `$status 1` if the certificate is invalid or expires within the given time span (defaults to 30 days)
or `$status 2` if you forgot to give the hostname you want to check (the port defaults to 443)...

