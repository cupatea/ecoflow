Rails.application.configure do
  config.good_job = {
    preserve_job_records: true,
    retry_on_unhandled_error: false,
    on_thread_error: ->(exception) { Rails.error.report(exception) },
    execution_mode: :async,
    queues: "*",
    max_threads: 5,
    poll_interval: 1,
    shutdown_timeout: 25,
    enable_cron: true,
    dashboard_default_locale: :uk,
    cron: {
      update_stats: {
        cron: "every 2 seconds",
        class: "PopulateStatsJob"
      },
      cleanup_stats: {
        cron: "every 6 hours",
        class: "CleanupStatsJob"
      }
    }
  }
end
