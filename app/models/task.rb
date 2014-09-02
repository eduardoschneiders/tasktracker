class Task < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(deleted: nil) }
end
