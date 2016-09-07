class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :change_subject, :valid, :valid_quiz2]
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
          session[:game] = 'creater'
        else
          @rendering = 'game'
        end

    elsif @game.opponent_id == current_user.id
      
        if @game.status != true
          @game.update_attribute(:status, true)
          @rendering = 'game'
          session[:game] = 'opponent'
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

  def change_subject
    @game.update_attribute(:current_subject, params[:choose_subject][:subject])
    session[:quiz] = 'quiz'
    redirect_to @game
  end

  def valid
    if @game.games_count == 9
      @game.increment!(:games_count, 1)

      if params[:quiz][:answer] == 'true'
        if @game.creater_id == current_user.id
          @game.increment!(:creater_scores, 1)
        elsif @game.opponent_id == current_user.id
          @game.increment!(:opponent_scores, 1)
        end
      end

      session[:game] = 'finish'
      redirect_to @game
    else
      if params[:quiz][:answer] == 'true'
        if @game.creater_id == current_user.id
          @game.update_attribute(:playing, false)
          @game.increment!(:creater_scores, 1)
          @game.increment!(:games_count, 1)
          @game.update_attribute(:current_question, params[:quiz][:current_question])
          session[:game] = 'waiting_opponent'
          session[:wait] = 'load'
          flash[:notice] = 'Правильный ответ'
          redirect_to @game
        elsif @game.opponent_id == current_user.id
          @game.update_attribute(:playing, false)
          @game.increment!(:opponent_scores, 1)
          @game.increment!(:games_count, 1)
          @game.update_attribute(:current_question, params[:quiz][:current_question])
          session[:game] = 'waiting_opponent'
          session[:wait] = 'load'
          flash[:notice] = 'Правильный ответ'
          redirect_to @game
        end
      else
        @game.update_attribute(:playing, false)
        @game.increment!(:games_count, 1)
        @game.update_attribute(:current_question, params[:quiz][:current_question])
        session[:game] = 'waiting_opponent'
        session[:wait] = 'load'
        flash[:error] = 'Не правильный ответ'
        redirect_to @game
      end
    end
  end

  def valid_quiz2
    if @game.games_count == 9
      @game.increment!(:games_count, 1)

      if params[:quiz][:answer] == 'true'
        if @game.creater_id == current_user.id
          @game.increment!(:creater_scores, 1)
        elsif @game.opponent_id == current_user.id
          @game.increment!(:opponent_scores, 1)
        end
      end

      session[:game] = 'finish'
      redirect_to @game
    else
      if params[:quiz][:answer] == 'true'
        if @game.creater_id == current_user.id
          @game.increment!(:games_count, 1)
          @game.increment!(:creater_scores, 1)
          session[:game] = 'quiz'
          session[:quiz] = 'choose_subject'
          flash[:notice] = 'Правильный ответ'
          redirect_to @game
        elsif @game.opponent_id == current_user.id
          @game.increment!(:games_count, 1)
          @game.increment!(:opponent_scores, 1)
          session[:game] = 'quiz'
          session[:quiz] = 'choose_subject'
          flash[:notice] = 'Правильный ответ'
          redirect_to @game
        end
      else
        @game.increment!(:games_count, 1)
        session[:game] = 'quiz'
        session[:quiz] = 'choose_subject'
        flash[:error] = 'Не правильный ответ'
        redirect_to @game
      end
    end
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
