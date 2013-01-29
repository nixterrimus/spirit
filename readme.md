# Readme

Spirit is your personal internet of things hub.  It makes it simple fo
r you to manage all of the connected things in your life; things like
lights, tvs, media centers, music players, and washing machines can
all be managed through a single interface.

Spirit is still a young project and is progressing quickly.

You can see what is being worked on, and planned for at the [Pivotal
Tracker for
Spirit](https://www.pivotaltracker.com/projects/730889/stories#)


## A quick example

```ruby
Spirit.configure do |config|
  config.setting = 'setting'
end

Spirit.devices

Spirit.devices << Device::Light.new
Spirit.devices.save

Spirit.devices
```


