class AddCurrentSubjectToGames < ActiveRecord::Migration
  def change
    add_column :games, :current_subject, :integer
  end
end
