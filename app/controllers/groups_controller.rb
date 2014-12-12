class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    group.update_attributes(group_params)
    flash[:notice] = 'Group updated with success.'
    redirect_to groups_path
  end

  def create
    Group.create(group_params)
    flash[:notice] = 'Group created with success.'
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    respond_to do |format|
      if destroy_group_tasks && @group.destroy
        format.json { render json: { group: @group, message: 'Group deleted with success.' }, status: :created, location: @group }
      end
    end
  end

  private

  def destroy_group_tasks
    Task.where(group: @group).each{ |task| task.destroy }
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
