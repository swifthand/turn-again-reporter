# A Turn-like Minitest Reporter (Again)

One of my favorite aspects of the now-abandoned [turn gem](https://github.com/turn-project/turn) was how the status banners for each test (i.e. PASS, FAIL, ERROR, SKIP) lined up nicely on the left side, providing a comfy, at-a-glance view.

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

TurnAgainReporter's initializer will pass on all existing Minitest::Reporters::BaseReporter keyword arguments, such as `color: true` but uses some of its own for some customization:

  1. The `indent` keyword can specify the indentation from the left of the console when running. The default is 4 to faithfully mimic turn itself.
  2. *Unlike turn*, the duration measurements in next to the test status do not include hours, because the vast majority of tests do not require a whole hour for a single test case. However, hours can be re-enabled by passing the `:hours` keyword as `true`.
  3. The colors that correspond to the test status flags (`PASS`, `FAIL`, `ERROR`, `SKIP`) can be customized by passing in the symbol of an ansi primary color names for the options `pass_color`, `fail_color`, `error_color` and `skip_color`, respectively. Valid names for ANSI primary colors are `:black`, `:red`, `:green`, `:yellow`, `:blue`, `:magenta`, `:cyan`, and `:white`. Additionally `:no_color` can be specified if you want to turn off color only for a specific status.

An example of these options:

```ruby

Minitest::Reporters.use!(
  Minitest::Reporters::TurnAgainReporter.new(
    hours: true, indent: 2, skip_color: :yellow
  ))
```


## Demonstration tests

Rake test tasks exist for demonstrating the output of this gem. Current tasks are:

- `rake pass-format`
- `rake fail-format`
- `rake error-format`
- `rake skip-format`
- `rake crazy-colors`
- `rake indent-option`
- `rake hours-option`

The usual `rake test` task will simply run all of the demonstration files together. This is not particularly useful. Because this necessarily includes purposeful errors and failures, will fail. Please do not file any issues related to these intended failures. Furthermore, because individual demonstration tests set different configuration settings for the whole suite, subsequent runs may have different formatting depending on which demonstration gets run first (as its settings take precendent).


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
