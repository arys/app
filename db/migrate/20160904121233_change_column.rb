class ChangeColumn < ActiveRecord::Migration
  def change
  	change_column_default :game, :status, false
  end
end
