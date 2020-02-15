require "pubnub"

pubnub = Pubnub.new(
  subscribe_key: "sub-c-78806dd4-42a6-11e4-aed8-02ee2ddab7fe"
)

callback = Pubnub::SubscribeCallback.new(
  message: lambda do |envelope|
    country_code = envelope.result[:data][:message]['place']['country_code']
    text = envelope.result[:data][:message]['text']
    if country_code == 'JP'
      puts "message: #{text}"
    end
  end
)

pubnub.add_listener(callback: callback)

pubnub.subscribe(
  channels: ['pubnub-twitter'],
)

while pubnub.subscribed_channels.size > 0 do
  sleep 1
end
