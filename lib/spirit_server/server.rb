class SpiritHTTPServer < Sinatra::Base
  get '/devices' do
    content_type :json
    devices = Spirit.devices
    serializer = ActiveModel::ArraySerializer.new(devices, each_serializer: DeviceSerializer)
    serializer.to_json
  end

  get '/devices/:id' do
    content_type :json    
    device = Device.find(params[:id])
    serializer = DeviceSerializer.new(device)
    serializer.to_json
  end
end
