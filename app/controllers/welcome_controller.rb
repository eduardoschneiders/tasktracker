class WelcomeController < ApplicationController
  def index
    if current_user
      tasks                   = { done: {}, todo: {} }
      total_uncompleted_tasks = current_user.tasks.where('created_at < ?', 1.month.ago).count
      uncompleted_tasks       = current_user.tasks.where('created_at >= ?', 1.month.ago).group('date(created_at)').count.to_a
      total_completed_tasks   = 0
      completed_tasks         = current_user.tasks.where('completed_at >= ?', 1.month.ago).group('date(completed_at)').count.to_a

      uncompleted_tasks.each do |task|
        day = task[0].split('-').last
        month = task[0].split('-')[1]
        key = "#{day}/#{month}"
        tasks[:todo][key] = task[1]
      end

      completed_tasks.each do |task|
        day = task[0].split('-').last
        month = task[0].split('-')[1]
        key = "#{day}/#{month}"
        tasks[:done][key] = task[1]
      end

      start             = 1.month.ago.to_date
      stop              = Date.today.to_date
      @processed_tasks  = []
      total_done        = 0
      total_todo        = current_user.tasks.where('created_at < ?', 1.month.ago).count

      (start..stop).each do |date|
        day         = date.strftime('%d')
        month       = date.strftime('%m')
        key         = "#{day}/#{month}"
        total_done  += tasks[:done][key] || 0
        total_todo  += tasks[:todo][key] || 0
        total_todo  -= tasks[:done][key] || 0

        @processed_tasks << { day: day, done: total_done, todo: total_todo }
      end
    else
      @tasks_count = Task.count
      @users_count = User.count
    end
  end
end
