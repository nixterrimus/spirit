class Trigger
  include Toy::Store
  include Toy::Store::All

  # Trigger is listening for something
  # attribute :event_id

  attribute :action_id, String

  def apply(event)
    event.apply
  end

  def action
    Action.find(action_id)
  end
end
