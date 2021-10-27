# frozen_string_literal: true

module FixturesHelper
  def fixture_file_path(filename)
    File.join(".", "spec", "fixtures", filename).to_s
  end

  def open_fixture_file(filename)
    File.open fixture_file_path(filename)
  end

  def read_fixture_file(filename)
    File.read fixture_file_path(filename)
  end

  def yaml_fixture_file(filename)
    YAML.load_file(fixture_file_path(filename))
  end
end

RSpec.configure do |config|
  config.include FixturesHelper
end
