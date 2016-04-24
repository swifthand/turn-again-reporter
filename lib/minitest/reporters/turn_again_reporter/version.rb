##
# So the convention of burying a VERSION constant inside a .version file
# and requiring it from within a gemspec breaks down when the namespace you
# need to bury it in has a dependency on (i.e. inherits from) some
# yet-to-be-loaded class.
#
# Consequently, we have an ugly shim to set up the heirarchy that Minitest
# should later fill in and use.
unless defined?(Minitest::StatisticsReporter)
  module Minitest
    class AbstractReporter; end
    class Reporter < AbstractReporter; end
    class StatisticsReporter < Reporter; end
  end
end

##
# Which is just an opening act for the hierarchy that Minitest::Reporters uses.
unless defined?(Minitest::Reporters::BaseReporter)
  module Minitest
    module Reporters
      class BaseReporter < Minitest::StatisticsReporter; end
    end
  end
end

##
# And now we can safely declare a version deep inside something that needs to
# inherit from Minitest::Reporters::BaseReporter.
module Minitest
  module Reporters
    class TurnAgainReporter < BaseReporter
      VERSION = "1.0.2"
    end
  end
end
