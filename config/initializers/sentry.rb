Sentry.init do |config|
  config.dsn = 'https://3bac5aab397b40f7887a0a0c56baf257@o1060543.ingest.sentry.io/6050189'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
