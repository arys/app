class RemoveStatusFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :status, :integer
  end
end
