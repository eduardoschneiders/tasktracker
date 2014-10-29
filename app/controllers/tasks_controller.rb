class TasksController < ApplicationController
  before_filter :can_access_logged

  def index
    @tasks = Task.active.where(user: current_user).paginate(page: params[:page], per_page: 15)
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params.merge(user: current_user))
    flash[:notice] = 'Task created with success'
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(task_params)
    flash[:notice] = 'Task updated with success'
    redirect_to tasks_path
  end

  def destroy
    task = Task.find(params[:id])
    task.deleted = true
    task.save

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task deleted with success' }, status: :created, location: task }
      end
    end

  end

  def complete
    task              = current_user.tasks.find(params[:id])
    task.completed    = true
    task.completed_at = Time.now

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task completed with success' }, status: :created, location: task }
      end
    end
  end

  private

  def task_params
    params.require('task').permit(:name, :completed)
  end
end
