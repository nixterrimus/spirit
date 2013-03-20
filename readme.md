
# Spirit: Your Personal Internet of Things Hub
`Control Anything, Remember Everything`

Spirit is your personal internet of things hub.  It makes it simple fo
r you to manage all of the connected things in your life; things like
lights, tvs, media centers, music players, and washing machines can
all be managed through a single interface.

Here's a more consumer facing look at what spirit is: [Welcome to
Spirit](http://blog.dcxn.com/2013/03/16/welcome-to-spirit/)

Spirit is still a young project and is progressing quickly.

## Is it ready yet? Can I use it?

No, not quite yet.  Spirit is in very active development and lots of things are moving, being developed, and changed.

## Getting Configured

Out of the box spirit needs to configuration.  Hooray!  However with no
configuration everything will live in memory until the end of the
program and then cease to be.  If, however, you'd like your devices and
adapters to continue to exist between runs, it's easy to setup spirit
with a way to store the information.

```ruby
Spirit.configure do |config|
  config.persistance_store = Moneta.new(:File, dir: "persistance")
end
```

Spirit supports any of the *numerous* backends provided by
`Moneta`(https://github.com/minad/moneta).  You have all kinds of
options to choose from: files, memory, Couch DBs, Memcaches and more.

File is probably a pretty good choice for most uses, Spirit doesn't do a
whole lot of reading and writing to the storage backend.  When the
program starts up it re-reads the state and when devices are added or
remove they are also updated.

## Devices

Devices are how spirit keeps track of how it thinks the world looks.
They are what make up spirit's internal representation.  They contain
information like how bright a light is, whether a media center is
playing or not, and what color a light is.  When they get updated they
talk to an `adapter` to actually make a change happen.

Spirit, right now, has a pretty small library of devices: `Light`,
`DimmableLight` and `ColorableLight`.  This is a library that will
continue to grow and evolve, though.  Eventually it will know about all
kinds of things.

You can get a list of devices that spirit knows about like this:


```
Spirit.devices
=> [#<Device::Light:0x007ff805a394e0 @adapter=#<Adapter::NilAdapter:0x007ff805a38a90 @uuid="63d939f8-f9a3-4827-91fe-64845bf1ebd4">, @configuration={}, @uuid="d8f24574-a4c5-4f57-b712-d4d761ed4d06">]
```

`Spirit.devices` returns an array.  In it we have just one device, a
`Device::Light`.

## Device Abilities

Devices are really small and simple classes.  For example, here's one
for a basic dimmable light:

```ruby
class DimmableLight < Device::Base
  include Abilities::Switchable
  include Abilities::Dimmable
end
```

The device class is made up of abilities.  These abilities are what
really give devices their power.  Because a device is composed of a
several abilities, it's easy to create a device that's a mix of all
different things.

These abilities also are important because they are the contract the
device agrees to exist by.  These abilities define the controls that
are avialable for that device in the web interface.

The switchable ability has an `on` and `off` method.  The user
interface for `switchable` will probably have an on button and an off
button.  Then, any devices that includes the switchable ability will
also have that on and off button.

Any device can give a list of it's abilites:

```ruby
> device = Device::Light.new
> device.abilities
=> ["switchable"]
```

## Adapters

Adapters are what take a device and make it happen in the real world.
Think about it this way: suppose I have an LED that can respond to
network commands to update how bright it is and suppose I also have a
normal house light that can take serial commands to update how bright it
is.  Both of these things are lights.  They both have brightness.  But
when it comes to actually changing the brightness, they accomplish it
differently.  This is where adapters come in.  Adapters are the thing
that translate what spirit *thinks* a device looks like into the real
world.

Adapters are still a work in progress but there wil be an ever growing
list of adapters that work with devices that spirit understands.  The
goal is to make writing an adapter as painless as possible.

Right now there is one really boring adapter in Spirit, the
`NilAdapter`.

You can get a list of adapters by calling:

```
Spirit.adapters
```

## Presets

Presets let a specific look be saved.  A preset can store a collection of target devices each with target states.

# A little More about the project

## Okay, who's involved with this?

Right now, it's Nick Rowe.

## Is it good?

Yes, but it's not ready yet.

## This sounds cool, how can I help

Thanks, that means a lot!  You can help by supporting
[@nixterrimus](http://twitter.com/nixterrimus) with thoughts, ideas or
suggestions.  Eventually I want help building a library of devices and
adapters.  Spirit should know how to talk to everything.  Won't that be
awesome?

The code is evolving and changing and the API is ever evolving.  In
these exciting, and tumultous early days, if you're interested in
working on the code and near San Francisco, I would love to pair program
on it.  Interested? Contact me on twitter.  [@nixterrimus](http://twitter.com/nixterrimus) 

## Tracker

You can see what is being worked on, and planned for at the [Pivotal
Tracker for
Spirit](https://www.pivotaltracker.com/projects/730889/stories#)


[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/96bd5ee72b2902f6f59f64f543880874 "githalytics.com")](http://githalytics.com/nixterrimus/spirit)
