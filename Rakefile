require 'bundler/gem_tasks'
require 'rake/testtask'

require 'pry'
def make_minitest_options(args)
  args ||= {}
  options = []
  options << "--name=#{Shellwords.escape(args[:name])} -v" if args.has_key?(:name)
  options.join(" ")
end

Rake::TestTask.new do |t,args|
  t.pattern = "test/test_*.rb"
end

namespace :test do
  desc "Run just one test based on the name"
  task :named, [:name] do |t, args|

    test_options = make_minitest_options(args)

    task_name = "test with opts: #{test_options}"

    Rake::TestTask.new(task_name) do |test_task|
      test_task.pattern = "test/test_*.rb"
      test_task.options =  test_options
    end

    Rake::Task[task_name].execute
  end
end

task default: :test
