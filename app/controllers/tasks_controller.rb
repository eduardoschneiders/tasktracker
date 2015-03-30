class TasksController < ApplicationController
  before_filter :can_access_logged

  def index
    @groups = Group.active.where(user: current_user).all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.create(task_params.merge(user: current_user))

    respond_to do |format|
      format.json { render json: { task: task, message: 'Task created with success.' }, status: :created, location: task }
      format.html { flash[:notice] = 'Task created with success.'; redirect_to tasks_path }
    end
  end

  def html
    task = Task.find(params[:id])
    render partial: 'task', locals: { task: task }
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])

    respond_to do |format|
      if task.update_attributes(task_params)
        format.json { render json: { task: task, message: 'Task upated with success.' }, status: :created, location: task }
        format.html { flash[:notice] = 'Task updated with success.'; redirect_to tasks_path }
      end
    end
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
    task.completed_at = Time.now

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task marked as completed with success.' }, status: :ok, location: task }
      end
    end
  end

  def uncomplete
    task              = current_user.tasks.find(params[:id])
    task.completed_at = nil

    respond_to do |format|
      if task.save
        format.json { render json: { task: task, message: 'Task marked as uncompleted with success.' }, status: :ok, location: task }
      end
    end
  end

  def deleted
    @groups_tasks = Group.joins(:tasks).includes(:tasks).where(tasks: { deleted: true, user: current_user })
  end

  def permanently_destroy
    tasks = Task.where(user: current_user, deleted: true)

    respond_to do |format|
      if tasks.destroy_all
        format.json { render json: { task: tasks, message: 'All tasks destroied permanently with success.' }, status: :ok, location: tasks_path }
      end
    end
  end

  def restore
    task = Task.find(params[:id])

    respond_to do |format|
      if task.update_attributes(deleted: false, completed_at: nil)
        format.json { render json: { task: task, message: 'Task restored with success.' }, status: :ok, location: task }
      end
    end
  end

  private

  def task_params
    params.require('task').permit(:name, :group_id)
  end
end
