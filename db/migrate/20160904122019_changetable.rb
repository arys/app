class Changetable < ActiveRecord::Migration
  def change
  	change_column_default :games, :status, false
  end
end
