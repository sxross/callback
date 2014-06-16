# motion-callback

Allows for multi-branch callbacks from a single method. This allows for blocks of code
to be invoked in response to asynchronous events triggered in the called method.

## Installation

Add this line to your application's Gemfile:

    gem 'callback'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-callback

## Usage

Using `callbacks` is really easy. Just add it to your Gemfile. Then in your code do this:

```ruby
do_something_complicated do |on|
  on.success {
    # take actions based on success
  }
  on.failure {
    # crash and burn gracefully
  }
  on.indeterminate_state {
    # act really confused
  }
end
```

In your `do_something_complicated` method, write code like this:

```ruby
def do_something_complicated(&block)
  some_asynchronous_stuff{|status|
    case status
    when 'error' then block.call Callback.new(:error)
    when 'success' then block.call Callback.new(:success)
    when '???'     then block.call Callback.new(:indeterminate_state)
    end
  }
end
```

A better idea of why this is interesting is code that reaches out
to a remote for asynchronously-retrieved data like this:

```ruby
check_already_logged_in do |on|
  on.success{ transition_to_authenticated_user_section }
  on.failure{
    login do |on|
      on.success{ transition_to_authenticated_user_section }
      on.failure{ alert_user_to_screwup }
    end
  }
end
```

## Thanks To

[Emmanuel Oga](https://gist.github.com/EmmanuelOga)

and this Gist, which is essentially the entire Gem.

https://gist.github.com/EmmanuelOga/1417762

Note also [this blog post and the ensuing discussion](http://www.mattsears.com/articles/2011/11/27/ruby-blocks-as-dynamic-callbacks).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
