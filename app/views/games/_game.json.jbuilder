json.extract! game, :id, :creater_id, :opponent_id, :subject_id, :status, :creater_scores, :opponent_scores, :created_at, :updated_at
json.url game_url(game, format: :json)