# Proc vs Lambda: Argument Handling in Ruby

```
add = Proc.new  {|a,b| a + b }
add.call(1, 2)   # => 3
add.call(1)      # => `+': nil can't be coerced into Integer (TypeError)
```

Proc is less strict about arguments than a lambda, but the behavior we're observing is due to what "less strict" actually means.

---

## Lambda (`->`)

A lambda enforces **arity** (the number of arguments).

```ruby
add = ->(a, b) { a + b }

add.call(1, 2) # => 3

add.call(1)
# ArgumentError: wrong number of arguments (given 1, expected 2)
```

A lambda behaves much like a normal method.

---

## Proc

A proc does **not** enforce arity. Missing arguments become `nil`, and extra arguments are ignored.

```ruby
add = Proc.new { |a, b| a + b }

add.call(1, 2)
# => 3

add.call(1)
# a = 1
# b = nil
```

At this point, Ruby has **not** raised an argument error.

Instead, your block executes:

```ruby
1 + nil
```

which raises:

```
TypeError: nil can't be coerced into Integer
```

That's exactly what your output shows. The proc accepted the missing argument just fine — it was your code (`a + b`) that failed because `b` was `nil`.

You can see it more clearly:

```ruby
p = Proc.new { |a, b| [a, b] }

p.call(1)
# => [1, nil]

p.call(1, 2, 3)
# => [1, 2]
```

Compare with a lambda:

```ruby
l = ->(a, b) { [a, b] }

l.call(1)
# ArgumentError

l.call(1, 2, 3)
# ArgumentError
```

---

## One Small Correction

This line:

```ruby
add = Proc.new (a, b) { a + b }
```

is **invalid Ruby syntax**, which is why you got a `SyntaxError`.

The correct syntax is:

```ruby
add = Proc.new { |a, b| a + b }
```

or

```ruby
add = proc { |a, b| a + b }
```

---

## Summary

| Feature | Lambda | Proc |
|---|---|---|
| Checks argument count | ✅ Yes | ❌ No |
| Missing arguments | `ArgumentError` | Filled with `nil` |
| Extra arguments | `ArgumentError` | Ignored |
| `return` behavior | Like a method | Returns from the enclosing method |

---

So the experiment actually **confirms** the difference:

- **Lambda**: rejected the call before executing the body.
- **Proc**: accepted the call, assigned `b = nil`, then your expression `a + b` raised a `TypeError`.
