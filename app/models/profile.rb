class Profile < ApplicationRecord
  encrypts :secret_key
end
