class Profile < ApplicationRecord
  scope :recent, -> { limit(5).order('updated_at desc') }
end
