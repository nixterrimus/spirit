class Trigger
  include Toy::Store
  include Toy::Store::All

  # Trigger is listening for something
  # attribute :event_id
  #
  # Has an action that it wants to perform
  # attribute :action_id

  def apply(event)
    # Apply the event - preset, device attribute changes, etc
  end
end
