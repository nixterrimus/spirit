class Event
  include Toy::Object

  attribute :raw_payload, String
  attribute :channel, String
end
