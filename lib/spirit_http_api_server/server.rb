class SpiritHTTPServer < Sinatra::Base
  get '/devices' do
    content_type :json
    devices = environment.devices
    serializer = ActiveModel::ArraySerializer.new(devices, each_serializer: DeviceSerializer)
    serializer.to_json
  end

  get '/devices/:id' do
    content_type :json
    device = Device.read(params[:id])
    serializer = DeviceSerializer.new(device)
    serializer.to_json
  end

  put '/devices/:id' do
    json = JSON.parse(request.body.read)
    device = Device.read(params[:id])
    driver = device.driver
    device.update_attributes(json.fetch('state', {}))
    driver.apply(device)
  end

  get '/presets' do
    content_type :json
    presets = environment.presets
    serializer = ActiveModel::ArraySerializer.new(presets, each_serializer: PresetSerializer)
    serializer.to_json
  end

  get '/presets/:id' do
    content_type :json
    device = Preset.read(params[:id])
    serializer = PresetSerializer.new(device)
    serializer.to_json
  end

  get '/drivers' do
    content_type :json
    drivers = environment.drivers
    serializer = ActiveModel::ArraySerializer.new(drivers, each_serializer: DriverSerializer)
    serializer.to_json
  end

  get '/driver/:id' do
    content_type :json
    device = Driver::Base.read(params[:id])
    serializer = DriverSerializer.new(device)
    serializer.to_json
  end

  def environment
    settings.environment
  end
end
