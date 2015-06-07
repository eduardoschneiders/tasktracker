class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  default_scope -> { order(:order) }
  scope :active, -> { where(deleted: false) }
  scope :uncompleted, -> { where(deleted: false, completed_at: nil) }
  scope :completed, -> { where(deleted: false).where.not(completed_at: nil) }

  before_save :create_next_order

  def completed?
    completed_at != nil
  end

  private

  def create_next_order
    return unless self.new_record?
    next_order = (self.group.tasks.maximum(:order) || 0) + 1
    self.order = next_order
  end
end
