class AddDefaultValueToDeleted < ActiveRecord::Migration
  def change
    change_column :groups, :deleted, :boolean, :default => false
    change_column :tasks, :deleted, :boolean, :default => false
  end
end
