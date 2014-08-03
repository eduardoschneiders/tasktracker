class TasksController < ApplicationController
  before_filter :can_access_logged

  def index
    @tasks = Task.where(user: current_user)
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
    task.destroy
    flash[:notice] = 'Task deleted with success'
    redirect_to tasks_path
  end

  def complete
    task = Task.find(params[:id])
    task.completed = true
    task.save
    flash[:notice] = 'Task updated with success'
    redirect_to tasks_path
  end

  private

  def task_params
    params.require('task').permit(:name, :completed)
  end
end
