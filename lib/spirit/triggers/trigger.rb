class Trigger
  include Toy::Store
  include Toy::Store::All

  attribute :action_id, String
  attribute :target_event, String

  def apply(event)
    worker.perform!(action) if applicable?(event)
  end

  def action
    Action.read(action_id)
  end

  def applicable?(event)
    !event.nil? && event.channel == target_event
  end

  def worker
    SuckerPunch::Queue[:actions]
  end

end
