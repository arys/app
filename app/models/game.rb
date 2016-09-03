class Game < ActiveRecord::Base
	validates :opponent_id, presence: true

	belongs_to :creater, :class_name => 'User'
	belongs_to :opponent, :class_name => 'User'
	belongs_to :subject
end
