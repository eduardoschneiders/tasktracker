class AddDeletedToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :deleted, :boolean
  end
end
