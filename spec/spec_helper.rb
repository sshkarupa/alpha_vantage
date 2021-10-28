# frozen_string_literal: true

require "alpha_vantage"
require "webmock/rspec"

begin
  require "pry-byebug"
rescue LoadError
end

ENV["RACK_ENV"] = "test"

Dir.glob("./spec/support/**/*.rb").sort.each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.default_formatter = "doc" if config.files_to_run.one?
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    AlphaVantage.configure do |c|
      c.api_key = "_api_key_"
    end
  end
end
