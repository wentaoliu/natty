class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.order(created_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: t('.success') }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: t('.success') }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group/1
  # DELETE /group/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group)
      .permit(:name, :description, {admin_ids:[]}, {member_ids:[]},
        permission_attributes: [:topic, :comment, :achievement, :bulletin,
          :instrument, :meeting, :news, :resource, :wiki])
  end
end
