namespace :tasks do
  desc 'Create order to each task'

  task :generate_order => :environment do
    puts "\ngenerating task orders"
    Task.all.each_with_index do |task, i|
      task.order = i
      task.save
      print '.'
    end
    puts "\nDone!"
  end
end
