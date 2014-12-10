class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  scope :active, -> { where(deleted: nil) }
end
