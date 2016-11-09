require "redis"
require "better_forex/version"
require "better_forex/quotation.rb"
require "better_forex/exchange_description.rb"
require "better_forex/exchange_collection.rb"
require "better_forex/exchange_redis_store.rb"
require "better_forex/baring_consumer.rb"

module BetterForex
  @debug_mode = true

  class << self
    attr_accessor :debug_mode

    def debug_mode?
      !!@debug_mode
    end
  end
  # Your code goes here...
end
