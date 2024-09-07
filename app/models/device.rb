class Device < ApplicationRecord
  has_many :stats

  def all_quota
    @all_quota ||= RestClient.new.all_quota(self)
  end

  def refresh_quota
    @all_quota = nil
    all_quota
  end

  def get_all_quota
    RestClient.new.all_quota(self)
  end

  def error_keys
    %w[pd.errCode bms_slave.errCode bms_bmsStatus.errCode bms_slave.allErrCode]
  end

  def has_errors?
    all_quota.values_at(*error_keys).any? { _1 != 0 }
  end
end
