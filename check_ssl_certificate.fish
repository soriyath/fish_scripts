#!/usr/bin/env fish
# see: https://unix.stackexchange.com/questions/234970/script-to-check-if-ssl-certificate-is-valid#answer-234975

function check_ssl_certificate --description "checks the validity of an SSL certificate, see usage with the --help flag."
    set --local CERTIFICATE_VALID 0
    set --local CERTIFICATE_INVALID_ERROR 1
    set --local ARGUMENT_MISSING_ERROR 2
    set --local DISPLAY_USAGE 3
    set --local DISPLAY_CODES 4
    set --local mutex_flags --exclusive help,codes,url --exclusive help,codes,port
    set --local options --name=check_ssl_certificate --max-args=2 $mutex_flags 'h/help'
    set --local option_specs 'u/url=' 'p/port=!_validate_int --min 0 --max 65535' 'c/codes' 'd/days=!_validate_int --min 0 --max 3650' 'v/verbose'

    function print_usage
        printf "Usage: check_ssl_certificate [OPTIONS]\n"
        printf "       checks the validity of the SSL certificate of the given host on the given port\n\n"
        printf "Options:\n"
        printf "  -h/--help       prints help and exits with code $DISPLAY_USAGE\n"
        printf "  -u/--url        the host to test, mandatory\n"
        printf "  -p/--port       the port of the host to test, defaults to 443\n"
        printf "  -d/--days       the SSL certificate validity days to check in days, defaults to 30, max 10 years\n"
        printf "  -c/--codes      prints the return codes of this script\n"
        printf "  -v/--verbose    prints out more information\n"
    end

    argparse $options $option_specs -- $argv
    or begin
        printf "Error $ARGUMENT_MISSING_ERROR: preconditions are not met. See usage.\n\n"
        print_usage
        return $ARGUMENT_MISSING_ERROR
    end

    if set --query _flag_help
        print_usage
        return $DISPLAY_USAGE
    end

    if set --query _flag_codes
        printf "check_ssl_certificate return codes:\n\n"
        printf "  $CERTIFICATE_VALID CERTIFICATE_VALID\n"
        printf "  $CERTIFICATE_INVALID_ERROR CERTIFICATE_INVALID_ERROR\n"
        printf "  $ARGUMENT_MISSING_ERROR ARGUMENT_MISSING_ERROR\n"
        printf "  $DISPLAY_USAGE DISPLAY_USAGE\n"
        printf "  $DISPLAY_CODES DISPLAY_CODES\n\n"
        printf "  read them by running: echo \$status\n"
        return $DISPLAY_CODES
    end

    if not set --query _flag_url
        printf "Error $ARGUMENT_MISSING_ERROR: Missing argument url to test. See usage.\n\n"
        print_usage
        return $ARGUMENT_MISSING_ERROR
    end

    set --query _flag_port
    or set --local _flag_port 443

    set --query _flag_days
    or set --local _flag_days 30
    set --local DURATION (math "$_flag_days * 86400") # convert days into seconds

    if set --query _flag_verbose
        printf "duration is: $DURATION seconds ($_flag_days days)\n"
        printf "checking SSL certificate validity for the next $_flag_days days of host $_flag_url on port $_flag_port...\n"
    end

    if true | openssl s_client -connect "$_flag_url:$_flag_port" -servername "$_flag_url" </dev/null 2>/dev/null | \
            openssl x509 -noout -checkend $DURATION
        if set --query _flag_verbose
            printf "$_flag_url:$_flag_port: SSL Certificate is ok for the next $_flag_days days.\n"
        end

        return $CERTIFICATE_VALID
    else
        if set --query _flag_verbose
            printf "$_flag_url:$_flag_port: SSL Certificate is not ok: either absent or will expire within the next $_flag_days days.\n"
        end

        return $CERTIFICATE_INVALID_ERROR
    end
end
