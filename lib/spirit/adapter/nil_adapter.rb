class Adapter::NilAdapter < Adapter::Base

  def apply(attributes)
    sleep 3
    nil
  end

  def update_device_state(device)
    nil
  end

end
