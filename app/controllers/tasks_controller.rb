class TasksController < ApplicationController
  before_filter :can_access_logged

  def index
    @groups = Group.all
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params.merge(user: current_user))
    flash[:notice] = 'Task created with success.'
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(task_params)
    flash[:notice] = 'Task updated with success.'
    redirect_to tasks_path
  end

  def destroy
    task = Task.find(params[:id])
    task.deleted = true
    task.save

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task deleted with success.' }, status: :created, location: task }
      end
    end

  end

  def complete
    task              = current_user.tasks.find(params[:id])
    task.completed    = true
    task.completed_at = Time.now

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task marked as completed with success.' }, status: :ok, location: task }
      end
    end
  end

  def uncomplete
    task              = current_user.tasks.find(params[:id])
    task.completed    = false
    task.completed_at = nil

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task marked as uncompleted with success.' }, status: :ok, location: task }
      end
    end
  end


  def deleted
    @groups_tasks = Group.all.includes(:tasks).where(tasks: { deleted: true })
  end

  private

  def task_params
    params.require('task').permit(:name, :completed, :group_id)
  end
end
