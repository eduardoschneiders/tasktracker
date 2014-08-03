class AddDeletedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :deleted, :boolean
  end
end
