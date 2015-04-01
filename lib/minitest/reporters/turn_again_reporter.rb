require 'minitest'
require 'minitest/reporters'

module Minitest
  module Reporters
    require 'turn_again_reporter/version'

    # Reporter whose output more closely mimics the format of the turn gem.
    # Specifically:
    # 1. The status banner and time on the left, which removes the need to
    #    limit the length of test names to not risk mis-aligning status flags.
    # 2. Displays time as minutes:seconds, optionally with hours as well.
    # 3. Allows configuration of indentation for each test output. Turn uses
    #    4 spaces, and thus this was chosen as the default.
    #
    # Source is mostly a verbatim copy from minitest-reporter's
    # SpecReporter class. Was unable to simply subclass SpecReporter without
    # significant code gynmastics or metaprogramming unbecoming of a simple
    # library formatter. This mostly due to SpecReporter's necessary
    # calls to super within the #record method, mixed with unavoidable output.
    #
    # @see https://github.com/kern/minitest-reporters/blob/master/lib/minitest/reporters/spec_reporter.rb SpecReporter
    # @see https://github.com/TwP/turn turn
    class TurnAgainReporter < BaseReporter
      include ANSI::Code
      include RelativePosition

      attr_reader :hours, :indent

      def initialize(options = {})
        @hours  = !!options.fetch(:hours, false)
        @indent =   options.fetch(:indent, 4)
        super(options)
      end

      def start
        super
        puts('Started with run options %s' % options[:args])
        puts
      end

      def report
        super
        puts('Finished in %.5fs' % total_time)
        print('%d tests, %d assertions, ' % [count, assertions])
        color = failures.zero? && errors.zero? ? :green : :red
        print(send(color) { '%d failures, %d errors, ' } % [failures, errors])
        print(yellow { '%d skips' } % skips)
        puts
      end

      def record(test)
        super
        print (' ' * indent)
        print_colored_status(test)
        print format_time(test.time)
        print test.name
        puts
        if !test.skipped? && test.failure
          print_info(test.failure)
          puts
        end
      end

protected ######################################################################

      def before_suite(suite)
        puts suite
      end

      def after_suite(suite)
        puts
      end

      def format_time(t)
        if hours
          ' (%02d:%02d:%06.3f) ' % [
            t.to_i / 3600,        # hours
            (t.to_i % 3600) / 60, # mins
            t % 60,               # seconds (kept as float)
          ]
        else
          ' (%02d:%06.3f) ' % [
            (t.to_i % 3600) / 60, # mins
            t % 60                # seconds (kept as float)
          ]
        end
      end

    end
  end
end
