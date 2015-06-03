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
    group = Group.create(group_params.merge(user: current_user))

    respond_to do |format|
      format.json { render json: { group: group, message: 'Group created with success.' }, status: :created, location: group }
      format.html { flash[:notice] = 'Group created with success.'; redirect_to groups_path }
    end
  end

  def destroy
    @group = Group.find(params[:id])
    respond_to do |format|
      if destroy_group_tasks && @group.update_attributes(deleted: true)
        format.json { render json: { group: @group, message: 'Group deleted with success.' }, status: :created, location: @group }
      end
    end
  end

  def html
    group = Group.find(params[:id])
    render partial: 'group', locals: { group: group }
  end

  def increment_tasks
    group         = Group.find(params[:id])
    tasks_id      = params.fetch(:tasks_id, [])
    current_task  = group.tasks.find(params[:current_task_id])

    require 'pry'; binding.pry
    current_task.update_attributes(order: params[:current_order])
    group.tasks.update_counters(tasks_id, order: 1)

    respond_to do |format|
      format.json { render nothing: true, status: :created }
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
