require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs        << "test"
  t.test_files  = Dir[File.join(File.dirname(__FILE__), 'test/**/*test.rb')]
end

demonstrations = [
  ["pass-format",   "pass_format_test.rb"   ],
  ["fail-format",   "fail_format_test.rb"   ],
  ["error-format",  "error_format_test.rb"  ],
  ["skip-format",   "skip_format_test.rb"   ],
  ["crazy-colors",  "color_options_test.rb" ],
  ["indent-option", "indent_option_test.rb" ],
  ["hours-option",  "hours_option_test.rb"  ],
]

demonstrations.each do |task_name, test_file|
  Rake::TestTask.new(task_name) do |t|
    t.libs        << "test"
    t.test_files  = [File.join(File.dirname(__FILE__), "test/integration/#{test_file}")]
  end
end
