class TasksController < ApplicationController
  def index
    @tasks = Task.where(user: current_user)
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params.merge(user: current_user))
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(task_params)
    redirect_to tasks_path
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

  def complete
    task = Task.find(params[:id])
    task.completed = true
    task.save
    redirect_to tasks_path
  end

  private

  def task_params
    params.require('task').permit(:name, :completed)
  end
end
