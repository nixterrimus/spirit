class Trigger
  include Toy::Store
  include Toy::Store::All

  def apply(event)
    # Apply the event - preset, device attribute changes, etc
  end
end
