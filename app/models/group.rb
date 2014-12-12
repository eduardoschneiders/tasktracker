class Group < ActiveRecord::Base
  has_many :tasks

  scope :active, -> { where(deleted: nil) }
end
