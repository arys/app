class AddCreaterIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :creater_id, :integer
  end
end
