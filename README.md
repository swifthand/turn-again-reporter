# A Turn-like Minitest Reporter (Again)

One of my favorite aspects of the now-abandoned [turn gem](https://github.com/turn-project/turn) was how the status banners for each test (i.e. PASS, FAIL, ERROR, SKIP) lined up nicely on the right side, providing a comfy, at-a-glance view.

These days I'm using the [minitest-reporters](https://github.com/kern/minitest-reporters) gem everywhere, but I've felt a little picky about the SpecReporter's claims to be "Turn-like". In addition to the right-aligned status banners being a little unfamiliar, since they come after the test name, it has the undesirable effect of limiting the length of my test names.

**Q: Do I really need tests with 60-character names?**

*A: Yes, sometimes. And it's none of your business!*

This might be better off included in the minitest-reporters gem itself, but it varies so minimally/cosmetically from its parent that I can't bring myself to bother the wonderful [Alex Kern](https://github.com/kern) about it with a pull request. It's really just an easy way for me to spread this code across all my projects without copy-pasting it. If someone else out there enjoys this formatting, I'm glad to hear it.

## Usage and Features (so-called)

In your `test_helper.rb` file, or equivalent where you `require 'minitest-reporters'`, just follow it up with:

```ruby
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::TurnAgainReporter.new
```

TurnAgainReporter's initializer will pass on all existing Minitest::Reporters::Base keyword arguments, such as `color: true` but uses two of its own for some customization:

  1. The `indent` keyword can specify the indentation from the left of the console when running. The default is 4 to faithfully mimic turn itself.
  2. *Unlike turn*, the duration measurements in next to the test status do not include hours, because the vast majority of tests do not require a whole hour for a single test case. However, hours can be re-enabled by passing the `:hours` keyword as `true`.

An example of these options:

```ruby

Minitest::Reporters.use!(
  Minitest::Reporters::TurnAgainReporter.new(
    color: true, hours: true, indent: 2
  ))
```

## Installation

The usual gem installation applies:

```ruby
gem install 'turn-again-reporter'
```

Or in your Gemfile:

```ruby
gem 'turn-again-reporter'
```

and run

```bash
$ bundle install
```

## Contributing

Fork away, but I can't imagine there's much to contribute.

That said, I would be interested to see how one might test the output of a test library? Play with redirecting STDOUT and write a few test cases for Fixnum or something? I would normally shy away from releasing untested code, but *honestly?!* This gem is just two `sprintf` statements and a re-arrangement of `puts` statements.
