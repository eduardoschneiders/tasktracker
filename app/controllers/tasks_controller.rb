class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    require 'pry'; binding.pry
    Task.create(task_params)
    redirect_to tasks_path
  end

  private

  def task_params
    params.require('task').permit(:name)
  end
end