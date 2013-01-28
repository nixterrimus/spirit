class Adapter::NilAdapter < Adapter::Base

  def apply_device_state(device)
    nil
  end

  def update_device_state(device)
    nil
  end

end
