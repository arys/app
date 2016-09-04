class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    if @game.creater_id == current_user.id

        if @game.status != true
          gon.watch.game_status = @game.status
          @rendering = 'waiting'
        else
          @rendering = 'game'
        end

    elsif @game.opponent_id == current_user.id

        if @game.status != true
          @game.update_attribute(:status, true)
          @rendering = 'game'
        else
          @rendering = 'game'
        end

    else
      flash[:error] = 'Это не ваша игра'
      redirect_to my_games_path
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
      @game = Game.new(game_params)

      if User.where(id: params[:game][:opponent_id]).exists?
          @game.save
          redirect_to @game, notice: 'Игра создана.'
      else
          flash.now[:error] = 'Пользователя с таким идентификатором не существует.'
          render :new
      end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my
    @my_games = Game.where(creater_id: current_user)
  end

  def invitations
    @invitations = Game.where(opponent_id: current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:creater_id, :opponent_id)
    end
end
