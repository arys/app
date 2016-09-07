class AddCurrentQuestionToGames < ActiveRecord::Migration
  def change
    add_column :games, :current_question, :integer
  end
end
