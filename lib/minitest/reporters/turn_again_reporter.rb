require 'minitest'
require 'minitest/reporters'
require 'minitest/reporters/base_reporter'

module Minitest
  module Reporters
    require 'minitest/reporters/turn_again_reporter/version'

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
      require 'ansi'
      include ANSI::Code
      include RelativePosition

      attr_reader :hours, :indent,
                  :pass_color, :fail_color, :error_color, :skip_color

      def initialize(options = {})
        options       = option_defaults.merge(options)
        @hours        = !!options.fetch(:hours)
        @indent       = options.fetch(:indent)
        @pass_color   = options.fetch(:pass_color)
        @fail_color   = options.fetch(:fail_color)
        @error_color  = options.fetch(:error_color)
        @skip_color   = options.fetch(:skip_color)
        super(options)
      end


      def option_defaults
        { hours:        false,
          indent:       4,
          pass_color:   :green,
          fail_color:   :red,
          error_color:  :yellow,
          skip_color:   :cyan,
        }
      end


      def start
        super
        puts('Started with run options %s' % options[:args])
        puts
      end


      def report
        super

        passed = count - (failures + errors + skips)

        puts('Finished in %.5fs' % total_time)
        puts
        print(bold { '%d tests' } % count)
        print(', ')
        print(send(report_passed_color)    { '%d passed' }   % passed)
        print(', ')
        print(send(report_failures_color)  { '%d failures' } % failures)
        print(', ')
        print(send(report_errors_color)    { '%d errors' }   % errors)
        print(', ')
        print(send(report_skips_color)     { '%d skips' }    % skips)
        print(', ')
        print('%d assertions' % assertions)
        puts
      end


      def print_colored_status(test)
        print_status = -> { pad_mark( result(test).to_s.upcase ) }
        if test.passed?
          print(send(pass_color,  &print_status))
        elsif test.skipped?
          print(send(skip_color,  &print_status))
        elsif test.error?
          print(send(error_color, &print_status))
        else
          print(send(fail_color,  &print_status))
        end
      end

      ##
      # To match the interface of printing of colors via methods with blocks.
      def no_color(&block)
        block.call
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

      ##
      # Divergence from Minitest::Reporters::SpecReporter is that here we are
      # printing the exception name with padding, so that it doesn't break the
      # visual flow/alignment of all the vertical, colored test result statuses.
      def print_info(e, name=true)
        print_with_info_padding("#{e.exception.class.to_s}: ") if name
        e.message.each_line { |line| print_with_info_padding(line) }

        # When e is a Minitest::UnexpectedError, the filtered backtrace is already part of the message printed out
        # by the previous line. In that case, and that case only, skip the backtrace output.
        unless e.is_a?(MiniTest::UnexpectedError)
          trace = filter_backtrace(e.backtrace)
          trace.each { |line| print_with_info_padding(line) }
        end
      end


protected ######################################################################


      def report_passed_color
        failures.zero? && errors.zero? ? pass_color : :no_color
      end


      def report_failures_color
        failures.zero? ? :no_color : fail_color
      end


      def report_errors_color
        errors.zero? ? :no_color : error_color
      end


      def report_skips_color
        skips.zero? ? :no_color : skip_color
      end


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
