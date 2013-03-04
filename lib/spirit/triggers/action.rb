class Action
  include Toy::Store
  include Toy::Store::All

  def apply
    # It is overridden by children and applies the action
    # apply the action
  end
end

