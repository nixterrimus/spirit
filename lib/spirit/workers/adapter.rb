module Worker
  class AdapterWorker
    include SuckerPunch::Worker

    def perform(device_id, adapter_id)
      device = Device.read(device_id)
      adapter = Adapter::Base.read(adapter_id)
      adapter.apply(device)
    end
  end
end
