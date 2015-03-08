class AchievementsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  
  # GET /admin/research/
  # GET /admin/research/index
  def index
    @per_page = 15
    @offset = 0
    @offset = @per_page * (params[:page].to_i - 1) unless params[:page].nil?
    if params[:search].nil?
      @count = Achievement.count
      @achievements = Achievement.limit(@per_page).offset(@offset)
    else
      @count = Achievement.where("title LIKE ?", "%#{params[:search]}%").count
      @achievements = Achievement.where("title LIKE ?", "%#{params[:search]}%").limit(@per_page).offset(@offset)
    end
  end

  # GET /admin/research/new
  def new
    @achievement = Achievement.new
  end

  # POST /admin/research/create
  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      # Handle a successful save
      redirect_to :action=>'index'
    else
      # Something went wrong
      render 'new'
    end
  end

  # GET /admin/research/edit
  def edit
    @achievement = Achievement.find(params[:id])
    access_denied unless @achievement.author == current_user.username or admin?
  end

  # POST /admin/research/update/:id
  def update
    @achievement=Research.find(params[:id])
    redirect_to :action=>'index' and return false if @research==nil
    access_denied unless @achievement.author == current_user.username or admin?
    if @achievement.update_attributes(params[:research])
      # Handle a successful update.
      redirect_to :action=>'index'
    else
      render 'edit'
    end
  end

  # GET /admin/research/destroy/:id
  def destroy
    @achievement = Research.find(params[:id])
    #redirect_to :action=>'index' and return false if @research==nil
    #access_denied unless @research.author == current_user.username or admin?
    @achievement.destroy
    redirect_to achievements_path
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title,:author,:link,:date,:content,:context)
  end
end
