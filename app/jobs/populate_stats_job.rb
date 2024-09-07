class PopulateStatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Device.find_each do |device|
      Stat.create(device: device, data: device.all_quota, error: device.has_errors?)
    end
  end
end
