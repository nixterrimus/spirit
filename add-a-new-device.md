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

You know what else is lame?  Adapters are going to get super fat.
Imagine with me a device that can play media (play, pause), set volume
(@volume), turn on and off (on and off), and make grind coffee.  Whoah.
Would you even pay for such a thing? Even if not, try to picture the
adapter.  It's a whole mess of code that does a whole bunch of things.
Too much. That's perhaps the fault of magician that created the device
but I wonder if it results in a file that's largely unmaintable because
of it's complexity.  On the other hand this device is serially connected
and I don't think it makes sense for the device to know that it's serial
connected.  When version 3.2.4 of the tuned-coffee-grindo comes out and
it now talks over http with a super RESTful API it would be pretty neat
to just swap out the adapter.
