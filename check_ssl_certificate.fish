#!/usr/local/bin/fish
# see: https://unix.stackexchange.com/questions/234970/script-to-check-if-ssl-certificate-is-valid#answer-234975
# return codes:
#  - 0: success;
#  - 1: SSL certificate for given hostname and port are expired or will expire within the next month;
#  - 2: there are missing parameters.

function check_ssl_certificate
  set HOST $argv[1]
  set PORT $argv[2]
  set ONE_MONTH 2592000
  # set ONE_YEAR 31104000 # for debugging purpose
  # set TEN_YEARS 311040000 # for debugging purpose
  # set ONE_HUNDRED_YEARS 3110400000 # doesn't work but is fun

  if test -z "$HOST" ; or test -z "$PORT"
    echo -e "Hostname or a port are missing.\nUsage: check_ssl_certificate www.google.com 443"
    return 2
  end

  if true | openssl s_client -connect $HOST:$PORT -servername $HOST </dev/null 2>/dev/null | \
    openssl x509 -noout -checkend $ONE_MONTH;
    echo "$HOST:$PORT SSL Certificate is ok."
    return 0
  else
    echo "$HOST:$PORT SSL Certificate is not ok: either absent or will expire within the next month."
    return 1
  end
end

