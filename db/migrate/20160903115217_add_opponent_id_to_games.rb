class AddOpponentIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :opponent_id, :integer
  end
end
