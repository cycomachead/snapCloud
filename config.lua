local config = require('lapis.config')

config({'development', 'production'}, {
    postgres = {
        host = os.getenv('DATABASE_URL') or '127.0.0.1:5432',
        user = os.getenv('DATABASE_USERNAME') or 'snap',
        password = os.getenv('DATABASE_PASSWORD') or 'snap-cloud-password',
        database = os.getenv('DATABASE_NAME') or 'snap_cloud'
    },
    session_name = 'snapsession',
    ssl_port = os.getenv('SSL_PORT') or 443,

    -- Change to the relative (or absolute) path of your disk storage
    -- directory.  Note that the user running Lapis needs to have
    -- read & write permissions to that path.
    store_path = 'store',

    -- for sending email
    mail_user = os.getenv('MAIL_SMTP_USER'),
    mail_password = os.getenv('MAIL_SMTP_PASSWORD'),
    mail_server = os.getenv('MAIL_SMTP_SERVER'),
    mail_from_name = "Snap!Cloud",
    mail_from = "postmaster@snap-cloud.cs10.org",
    mail_footer = "<br/><br/><p><small>Please do not reply to this email. This message was automatically generated by the Snap!Cloud. To contact an actual human being, please write to <a href='mailto:snap-support@bjc.berkeley.edu'>snap-support@bjc.berkeley.edu</a></small></p>"
})

config('development', {
    use_daemon = 'off',
    site_name = 'dev | Snap Cloud',
    hostname = 'localhost',
    port = os.getenv('PORT') or 8080,
    ssl_cert_file = os.getenv('SSL_CERT_FILE') or 'host.cer',
    ssl_cert_private_key = os.getenv('SSL_CERT_PRIVATE_KEY') or 'host.key',
    ssl_second_cert_file = os.getenv('SSL_SECOND_CERT_FILE'),
    ssl_second_cert_private_key = os.getenv('SSL_SECOND_CERT_PRIVATE_KEY'),
    num_workers = 1,
    code_cache = 'off',
    log_directive = 'stderr notice',
    logging = {
        queries = true,
        requests = true
    },
    secret = os.getenv('SESSION_SECRET_BASE') or 'this is a secret',
    measure_performance = true
})

config('production', {
    use_daemon = 'on',
    enable_https = true,
    port = os.getenv('PORT') or 80,
    site_name = 'Snap Cloud',
    hostname = os.getenv('HOSTNAME') or 'cloud.snap.berkeley.edu',
    ssl_cert_file = os.getenv('SSL_CERT_FILE'),
    ssl_cert_private_key = os.getenv('SSL_CERT_PRIVATE_KEY'),
    ssl_second_cert_file = os.getenv('SSL_SECOND_CERT_FILE'),
    ssl_second_cert_private_key = os.getenv('SSL_SECOND_CERT_PRIVATE_KEY'),
    secret = os.getenv('SESSION_SECRET_BASE'),
    num_workers = 8,
    code_cache = 'on',

    log_directive = 'logs/error.log warn',

    -- TODO: See if we can turn this on without a big hit
    measure_performance = false
})
