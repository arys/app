class Changescores < ActiveRecord::Migration
  def change
  	change_column_default :games, :creater_scores, 0
  	change_column_default :games, :opponent_scores, 0
  end
end
