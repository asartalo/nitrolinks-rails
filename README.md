# Nitrolinks

Nitrolinks is PJAX-like library for making website navigation fast and more like
modern web apps. Nitrolinks is inspired by and borrows heavily from
[Turbolinks](https://github.com/turbolinks/turbolinks) implementation on the
Rails-side.

## Warning! Not Production-Ready
This is an experiment and not yet heavily tested. Please don't use in critical
applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nitrolinks-rails'
```

And then execute:

$ bundle

Or install it yourself as:

$ gem install nitrolinks-rails

## Usage

Include nitrolinks in your application.js

```javascript
//= require nitrolinks
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
[https://github.com/asartlo/nitrolinks-rails](https://github.com/asartlo/nitrolinks-rails).

