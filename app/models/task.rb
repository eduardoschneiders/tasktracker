class Task < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(deleted: nil) }
  scope :current_user, -> { where(user: current_user) }
end