class WelcomeController < ApplicationController
  def index
    @tasks = current_user.tasks.where('completed_at >= ?', 30.days.ago).group('date(completed_at)').count.to_a
    @tasks.insert(0, ['Day', 'Tasks completed'])
    @tasks
  end
end
