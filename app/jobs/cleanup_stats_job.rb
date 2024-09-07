class CleanupStatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Stat.where("created_at < ?", 2.days.ago).delete_all
  end
end
