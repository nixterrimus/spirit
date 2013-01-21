# Readme

You can see what is being worked on, and planned for at the [Pivotal
Tracker for
Spirit](https://www.pivotaltracker.com/projects/730889/stories#)

Spirit is a ruby based home automation system.  It's the friendly ghost
that controls your house, automatically turns devices on and off, and
reacts to other changs in the environment.

I aim for it to be a reliable, extendable, well designed open source
project.

Right now it's just some ideas.  I would love feedback or encouragement.
Feel free to browse the code, for it or contact me
[@nixterrimus](twitter.com/nixterrimus) on
twitter.

## Setup

```ruby
Spirit.configure do |config|
  config.setting = 'setting'
end
```

