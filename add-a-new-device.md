With the architecture as it stands right now, to create a new device you
must:

Create a new class with a what you want to build and make it a child of
Device:

```ruby
class Toaster < Device
end
```

Tell the base class what kind of abilities it has (a toaster is mostly
just making toast or not so it's just a binary device:


```ruby
class Toaster < Device
  include Capabilities::BinaryDevice
end
```

And then implement an adapter to actually talk to the the toaster:

```ruby
class ToasterAdapter < Adapter::Base
  def on
    # turn on the toaster by pressing the button
  end

  def off
    # turn off the toaster by waving ones hands wildly
  end
end
```

And, finally link the two together:

```
adapter = ToasterAdapter.new
toaster = Toaster.new(adapter)
```

This seems kind of lame.  It seems like indirection, why should there be
two classes for something that's just being used once?  Having an
adapter seems like a testing advantage because the *how* is moved out
and a separate concern from what the device is doing.  But will adapters
ever be re-used? Hmmm.  It seems like there should be a better approach.

Then again, there might be multiple toasters in my house that are
controlled by a centralized toaster adapter.  In which case there would
be re-use:

```
toasty_toasty_adapter = ToasterAdapter.new
upstairs_toaster = Toaster.new(toasty_toasty_adapter)
downstairs_toaster = Toaster.new(toasty_toasty_adapter)
```
