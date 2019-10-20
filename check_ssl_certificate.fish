#!/usr/local/bin/fish
# see: https://unix.stackexchange.com/questions/234970/script-to-check-if-ssl-certificate-is-valid#answer-234975

function check_ssl_certificate
  if true | openssl s_client -connect $argv 2>/dev/null | openssl x509 -noout -checkend 0;
    echo "$argv SSL Certificate is not expired"
    return 0
  else
    echo "$argv SSL Certificate is either absent or expired"
    return 1
  end
end

