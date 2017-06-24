require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << 'tests'
  task.test_files = FileList['tests/test*.rb']
  task.verbose = true
end