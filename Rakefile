require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs        << "test"
  t.test_files  = Dir[File.join(File.dirname(__FILE__), 'test/**/*test.rb')]
end

Rake::TestTask.new("pass-format") do |t|
  t.libs        << "test"
  t.test_files  = [File.join(File.dirname(__FILE__), 'test/integration/pass_format_test.rb')]
end

Rake::TestTask.new("fail-format") do |t|
  t.libs        << "test"
  t.test_files  = [File.join(File.dirname(__FILE__), 'test/integration/fail_format_test.rb')]
end

Rake::TestTask.new("error-format") do |t|
  t.libs        << "test"
  t.test_files  = [File.join(File.dirname(__FILE__), 'test/integration/error_format_test.rb')]
end

Rake::TestTask.new("skip-format") do |t|
  t.libs        << "test"
  t.test_files  = [File.join(File.dirname(__FILE__), 'test/integration/skip_format_test.rb')]
end
