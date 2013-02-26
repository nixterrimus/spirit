class Trigger
  include Toy::Store
  include Toy::Store::All

  # Trigger is listening for something
  # Has an action that it wants to perform

  def apply(event)
    # Apply the event - preset, device attribute changes, etc
  end
end
