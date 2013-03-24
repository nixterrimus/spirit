module Worker
  class DriverWorker
    include SuckerPunch::Worker

    def perform(device_id, driver_id)
      device = Device.read(device_id)
      driver = Driver::Base.read(driver_id)
      driver.apply(device)
    end
  end
end
