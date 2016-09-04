class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :notifications

  def notifications
  	if defined?current_user.id
	  	@my_games_count = Game.where(creater_id: current_user.id).count
	  	@invitations_count = Game.where(opponent_id: current_user.id).count
	  end
  end
end
