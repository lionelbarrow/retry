# Retry

A few functions for trying again when things don't go as planned.

### Usage

Suppose you had a function, `some_func`, which might raise `SomeError`. If the function does raise that error, you'd like to try again. In that case, you could say:
```ruby
Retry.on_exception(SomeError) do
  some_func
end
```

(Note that if the function raises a different error, no retry will be attempted.)

If you'd like to retry a couple of times (let's say three), you can do that:
```ruby
Retry.several_times(SomeError, 3) do
  some_func
end
```

Sometimes you want to wait a bit before retrying. This example will retry twice, with a four second delay between each attempt:
```ruby
Retry.with_linear_backoff(SomeError, 2, 4) do
  some_func
end
```

Another common pattern is to wait more and more time between each attempt; this is usually called "exponential backoff". This example will retry 3 times, with a delay of 2, 4, and 8 seconds between each attempt:
```ruby
Retry.with_exponential_backoff(SomeError, 3, 2) do
  some_func
end
```

### License

The MIT License (MIT)

Copyright (c) 2013 Lionel Barrow

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
