# Fish scripts

Some Fish scripts to make my life easier

## check_ssl_certs

Checks if an SSL certificate is still valid.

### usage

run `./check_ssl_cert --host hostname --verbose`
e.g. `./check_ssl_cert --host www.google.com --verbose`

run `./check_ssl_cert -h` to check all the options

this will yield `$status 0` if certificate is not expired<br />
or `$status 1` if the certificate is invalid or expires within the given time span (defaults to 30 days)
or `$status 2` if you forgot to give the hostname you want to check (the port defaults to 443)...

