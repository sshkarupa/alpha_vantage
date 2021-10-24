# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "pry-byebug", platform: :mri

eval_gemfile "gemfiles/rubocop.gemfile"

local_gemfile = "#{File.dirname(__FILE__)}/Gemfile.local"
eval(File.read(local_gemfile)) if File.exist?(local_gemfile)  # rubocop:disable Security/Eval
