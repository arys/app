class AddPlayingToGames < ActiveRecord::Migration
  def change
    add_column :games, :playing, :boolean
  end
end
