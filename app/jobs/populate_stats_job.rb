class PopulateStatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    error_keys = %w[pd.errCode bms_slave.errCode bms_bmsStatus.errCode bms_slave.allErrCode]
    Device.find_each do |device|
      data = RestClient.new(Profile.first).all_quota(device)
      Stat.create(data: data, error: data.values_at(*error_keys).any? { _1 != 0 }, device: device)
    end
  end
end
