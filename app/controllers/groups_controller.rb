class GroupsController < ApplicationController
  def index
    @groups = Group.active.where(user: current_user).all
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])

    respond_to do |format|
      if group.update_attributes(group_params)
        format.json { render json: { group: group, message: 'Group upated with success.' }, status: :created, location: group }
        format.html { flash[:notice] = 'Group updated with success.'; redirect_to groups_path }
      end
    end
  end

  def create
    Group.create(group_params.merge(user: current_user))
    flash[:notice] = 'Group created with success.'
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    respond_to do |format|
      if destroy_group_tasks && @group.update_attributes(deleted: true)
        format.json { render json: { group: @group, message: 'Group deleted with success.' }, status: :created, location: @group }
      end
    end
  end

  private

  def destroy_group_tasks
    Task.where(user: current_user, group: @group).each { |task| task.update_attributes(deleted: true) }
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
