class AddOrderToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :order, :integer
    add_index :tasks, :order
  end
end
