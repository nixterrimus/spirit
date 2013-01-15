# Persisting Devices & Adapters between runs

Devices and adapters need to continue to exist between runs.  It seems
that there are two kinds of data that make up a device empheral stuff
like it's current brightness or time left in toaster cycle and the more
perminent stuff like what's the device's IP address (or the adapters IP
address).

The stuff that needs to be kept needs to serialized out somehow and then
written off to some kind of storage facility.  Then on next run the data
needs to be brought back from the depths of the warehouse and passed
back to the device or adapter.  *Cue warehouse scene from Indiana Jones*

The devices or adapter should have a good idea of the diferent kinds of
data and the serializer should take it into account.

This ends up being important because I want to have a script like this:

```ruby
Device.all.each_with_index do |device, index|
  puts "[#{index}]: device" if device.kind_of? Capabilities::BinaryDevice
end
puts "\nPicks a device to toggle off or on"
```

And have see the devices that I added last time still there and working.
