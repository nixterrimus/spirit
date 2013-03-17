class SpiritHTTPServer < Sinatra::Base
  get '/devices' do
    content_type :json
    devices = spirit.devices
    serializer = ActiveModel::ArraySerializer.new(devices, each_serializer: DeviceSerializer)
    serializer.to_json
  end

  get '/devices/:id' do
    content_type :json    
    device = spirit.devices.find(params[:id]).first
    serializer = DeviceSerializer.new(device)
    serializer.to_json
  end

  get '/presets' do
    content_type :json
    presets = spirit.presets
    serializer = ActiveModel::ArraySerializer.new(presets, each_serializer: PresetSerializer)
    serializer.to_json
  end

  def spirit
    settings.spirit
  end
end
