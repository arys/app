class AddGamesCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :games_count, :integer, :default => 0
  end
end
