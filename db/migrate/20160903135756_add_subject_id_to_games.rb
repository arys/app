class AddSubjectIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :subject_id, :integer
  end
end
