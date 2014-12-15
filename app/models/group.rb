class Group < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  scope :active, -> { where(deleted: nil) }
end
