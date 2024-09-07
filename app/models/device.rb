class Device < ApplicationRecord
  has_many :stats

  def get_all_quota
    RestClient.new.all_quota(self)
  end
end
