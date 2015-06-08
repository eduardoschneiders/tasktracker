class WelcomeController < ApplicationController
  def index
    if current_user
      # tasks                   = { done: {}, todo: {} }
      # total_uncompleted_tasks = current_user.tasks.active.where('created_at < ?', 1.month.ago).count
      # uncompleted_tasks       = current_user.tasks.active.where('created_at >= ?', 1.month.ago).group('date(created_at)').count.to_a
      # total_completed_tasks   = 0
      # completed_tasks         = current_user.tasks.active.where('completed_at >= ?', 1.month.ago).group('date(completed_at)').count.to_a

      # uncompleted_tasks.each do |task|
      #   day = task[0].to_s.split('-').last
      #   month = task[0].to_s.split('-')[1]
      #   key = "#{day}/#{month}"
      #   tasks[:todo][key] = task[1]
      # end

      # completed_tasks.each do |task|
      #   day = task[0].to_s.split('-').last
      #   month = task[0].to_s.split('-')[1]
      #   key = "#{day}/#{month}"
      #   tasks[:done][key] = task[1]
      # end

      # start             = 1.month.ago.to_date
      # stop              = Date.today.to_date
      # @processed_tasks  = []
      # total_done        = 0
      # total_todo        = current_user.tasks.active.where('created_at < ?', 1.month.ago).count

      # (start..stop).each do |date|
      #   day         = date.strftime('%d')
      #   month       = date.strftime('%m')
      #   key         = "#{day}/#{month}"
      #   total_done  += tasks[:done][key] || 0
      #   total_todo  += tasks[:todo][key] || 0
      #   total_todo  -= tasks[:done][key] || 0






        # @processed_tasks << { day: day, done: total_done, todo: total_todo }
      # end

      tasks                         = { todo: {}, completed: {} }
      unprocessed_tasks             = { todo: [], completed: [] }
      unprocessed_tasks[:todo]      = current_user.tasks.unscoped.active.where('created_at >= ?', 1.month.ago).group('date(created_at)').count.to_a
      unprocessed_tasks[:completed] = current_user.tasks.unscoped.active.where('completed_at >= ?', 1.month.ago).group('date(completed_at)').count.to_a

      tasks[:todo]      = process_tasks(unprocessed_tasks[:todo], :todo)
      tasks[:completed] = process_tasks(unprocessed_tasks[:completed], :completed)

      begin_date              = 1.month.ago.to_date
      end_date                = Date.today.to_date
      todo_tasks_counter      = current_user.tasks.active.where('created_at < ?', 1.month.ago).count
      completed_tasks_counter = 0
      @tasks                  = []

      (begin_date..end_date).each do |date|
        key       = "#{date.day}/#{date.month}"
        todo      = tasks[:todo][key] || 0
        completed = tasks[:completed][key] || 0

        todo_tasks_counter += todo - completed
        completed_tasks_counter += completed

        @tasks << { day: date.strftime('%d'), todo: todo_tasks_counter, completed: completed_tasks_counter }
      end
    else
      @tasks_count = Task.count
      @users_count = User.count
    end
  end

  private

  def process_tasks(tasks, status)
    processed = {}
    tasks.each do |task|
      day   = task[0].to_date.day
      month = task[0].to_date.month
      key   = "#{day}/#{month}"

      processed[key] = task[1]
    end
    processed
  end
end
