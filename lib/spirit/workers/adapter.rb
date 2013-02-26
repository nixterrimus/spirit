module Worker
  class AdapterWorker
    include SuckerPunch::Worker

    def perform(device_id, adapter_id)
      device = ColorableLight.read(device_id)
      adapter = Adapter::HueAdapter.read(adapter_id)
      adapter.apply(device.attributes)
    end
  end
end
