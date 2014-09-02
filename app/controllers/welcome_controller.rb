class WelcomeController < ApplicationController
  def index
    if current_user
      @tasks = current_user.tasks.where('completed_at >= ?', 30.days.ago).group('date(completed_at)').count.to_a
    else
      @tasks_count = Task.count
      @users_count = User.count
    end
  end
end
