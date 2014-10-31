class WelcomeController < ApplicationController
  def index
    if current_user
      completed_tasks = 0
      @tasks = []
      @completed_tasks = current_user.tasks.where('completed_at >= ?', 30.days.ago).group('date(completed_at)').count.to_a
      @uncompleted_tasks = current_user.tasks.where('completed_at IS NULL').group('date(created_at)').count.to_a
      @completed_tasks.each do |day|
        completed_tasks += day[1]
        uncompleted_tasks = current_user.tasks.where('completed_at IS NULL and created_at <= ?', Date.parse(day[0])).count
        @tasks << [day[0], completed_tasks, uncompleted_tasks]
      end
        binding.pry
      30.days.map do |day|
      end

      # [date, completed, unconpleted]
      @completed_tasks = [
        ['2014-10-05', 4, 26], 
        ['2014-10-06', 10, 20], 
        ['2014-10-10', 11, 19], 
        ['2014-10-15', 20, 10], 
        ['2014-10-20', 30, 0],
        ['2014-10-20', 30, 0],
        ['2014-10-20', 30, 0],
        ['2014-10-22', 30, 5],
        ['2014-10-22', 33, 2],
        ['2014-10-25', 35, 0],
        ['2014-10-25', 35, 40],
        ['2014-10-25', 55, 20],
        ['2014-10-25', 75, 00],
      ]
    else
      @tasks_count = Task.count
      @users_count = User.count
    end
  end
end
