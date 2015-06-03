class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  default_scope -> { order(:order) }
  scope :active, -> { where(deleted: false) }
  scope :uncompleted, -> { where(deleted: false, completed_at: nil) }
  scope :completed, -> { where(deleted: false).where.not(completed_at: nil) }

  def completed?
    completed_at != nil
  end
end
