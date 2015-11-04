class AchievementsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_achievement, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /admin/research/
  # GET /admin/research/index
  def index
    res = Achievement.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @achievements = res.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /admin/research/new
  def new
    @achievement = Achievement.new
  end

  # POST /admin/research/create
  def create
    @achievement = Achievement.new(achievement_params)
    respond_to do |format|
      if @achievement.save
        format.html { redirect_to @achievement, notice: t('.success') }
        format.json { render :show, status: :created, location: @achievement }
      else
        format.html { render :new }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/achievement/edit
  def edit
  end

  # POST /admin/achievement/update/:id
  def update
    respond_to do |format|
      if @achievement.update(achievement_params)
        format.html { redirect_to @achievement, notice: t('.success') }
        format.json { render :show, status: :ok, location: @achievement }
      else
        format.html { render :edit }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /achievement/destroy/:id
  def destroy
    @achievement.destroy
    respond_to do |format|
      format.html { redirect_to achievements_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_achievement
    @achievement = Achievement.find(params[:id])
  end

  def achievement_params
    params.require(:achievement)
      .permit(:title, :author, :link, :type, :date, :content, :public)
  end
end
