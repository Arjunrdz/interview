Ruby's object model is intentionally "circular", which is why it looks confusing at first. Here's a visualization:

### Class inheritance (`superclass` chain)

```text
                 nil
                  ▲
                  │
           BasicObject
                  ▲
                  │
               Object
                  ▲
                  │
               Module
                  ▲
                  │
                Class
```

This corresponds to:

```ruby
Class.superclass        # => Module
Module.superclass       # => Object
Object.superclass       # => BasicObject
BasicObject.superclass  # => nil
```

---

### Object instantiation (`.class`)

Every one of these is an object, and their class is `Class` (except `Kernel`).

```text
                  Class
                    ▲
      ┌─────────────┼──────────────┐
      │             │              │
   Object        Module       BasicObject
      ▲
      │
   (all normal objects)
```

Which matches:

```ruby
Object.class        # => Class
Module.class        # => Class
Class.class         # => Class
BasicObject.class   # => Class
```

Notice the interesting part:

```text
Class.class
     │
     ▼
   Class
```

`Class` is an instance of itself.

---

### Where does `Kernel` fit?

`Kernel` is **not** a class—it's a module.

```text
          Module
             ▲
             │
          Kernel
```

So:

```ruby
Kernel.class
# => Module
```

And `Kernel` is mixed into `Object`, which is why every normal Ruby object gets methods like:

* `puts`
* `print`
* `gets`
* `loop`
* `raise`

You can think of it like this:

```text
              Module
                 ▲
                 │
             Kernel
                 │
          (included into)
                 │
                 ▼
              Object
                 ▲
                 │
          Your classes
```

---

## Complete picture

```text
                    Class
                      ▲
                      │  .class
      ┌───────────────┼────────────────┐
      │               │                │
 BasicObject       Object          Module
      ▲               ▲               ▲
      │               │               │
      └──── superclass chain ─────────┘
                      ▲
                      │
                    Class
                    (instance of itself)

Module
   ▲
   │
Kernel
   │
   └── included into Object
```

Or in table form:

| Expression               | Result        | Why                                              |
| ------------------------ | ------------- | ------------------------------------------------ |
| `Kernel.class`           | `Module`      | Kernel is a module                               |
| `Module.class`           | `Class`       | Modules are instances of `Class`                 |
| `Class.class`            | `Class`       | `Class` is an instance of itself                 |
| `Class.superclass`       | `Module`      | Class inherits from Module                       |
| `Module.superclass`      | `Object`      | Module inherits from Object                      |
| `Object.superclass`      | `BasicObject` | Root of normal objects                           |
| `BasicObject.superclass` | `nil`         | Top of the inheritance hierarchy                 |
| `BasicObject.class`      | `Class`       | BasicObject is itself an object created by Class |
| `Object.class`           | `Class`       | Object is an instance of Class                   |

The key idea is that Ruby has **two different relationships** operating simultaneously:

1. **Inheritance (`superclass`)** — how classes inherit behavior.
2. **Instantiation (`.class`)** — every class or module is itself an object, and those objects are instances of `Class` (except `Kernel`, which is an instance of `Module`). This dual relationship is what gives Ruby its highly reflective object model.
