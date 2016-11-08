require 'test_helper'

class BetterForexTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BetterForex::VERSION
  end

  def test_it_does_something_useful
    BetterForex::BaringConsumer.start()

  end
end
