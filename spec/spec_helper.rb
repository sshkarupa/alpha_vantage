# frozen_string_literal: true

require "alpha_vantage"
require "webmock/rspec"

begin
  require "pry-byebug"
rescue LoadError
end

ENV["RUBY_NEXT_WARN"] = "false"
ENV["RUBY_NEXT_EDGE"] = "1"
require "ruby-next/language/runtime" unless ENV["CI"]

ENV["RACK_ENV"] = "test"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
