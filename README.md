# HTTPcap

parse pcap, then return http request and response

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'httpcap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install httpcap

## Usage

```ruby
HTTPcap.http_flows('./http.pcap') do |flow|
  p flow.request.body
  # => "{\"userId\":12345}"
  p flow.request.headers['Authorization']
  # => "Bearer hogehoge123455567890"
  p flow.response.http_status
  # => 200
  p flow.response.body
  # => "{\"userId\":12345,\"name\":\"naari3\",\"author\":true}"
  p flow.request.headers['Content-Length']
  # => "46"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/naari3/httpcap.
