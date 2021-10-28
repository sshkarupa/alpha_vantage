[![Build](https://github.com/sshkarupa/alpha_vantage/workflows/Build/badge.svg)](https://github.com/sshkarupa/alpha_vantage/actions)
# AlphaVantage

A ruby wrapper for [Alpha VAntage API](https://www.alphavantage.co/documentation/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alpha_vantage'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install alpha_vantage

## Usage

The library needs to be configured with your api key which you can obtain from https://www.alphavantage.co/support/#api-key.
If you are using Rails, you can put this code into an initializer.

```ruby
require "alpha_vantage"

AlphaVantage.configure do |config|
  config.api_key = "your-api-key"
end
```

### Stock Time Series

```ruby
search = AlphaVantage::TimeSeries.search(keywords: "tesco")

time_series = AlphaVantage::TimeSeries.new(symbol: "IBM")

timeseries.intraday(interval: "60m")
```

### Fundamental data

### Forex


### Cryptocurrencies


### Economic Indicators


### Technical Indicators

### Sector

This class returns the realtime and historical sector performances calculated from S&P500 incumbents.

```ruby
sector = AlphaVantage::Sector.new
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sshkarupa/alpha_vantage. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sshkarupa/alpha_vantage/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AlphaVantage project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sshkarupa/alpha_vantage/blob/master/CODE_OF_CONDUCT.md).
