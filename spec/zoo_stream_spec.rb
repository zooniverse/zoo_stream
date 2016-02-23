require 'spec_helper'

describe ZooStream do
  it 'has a version number' do
    expect(ZooStream::VERSION).not_to be nil
  end

  describe '#publish' do
    it 'does nothing if the publisher is not set' do
      ZooStream.publisher = nil
      expect { ZooStream.publish(event: 'event', data: {}) }.not_to raise_error
    end

    it 'calls publish on the publisher if set' do
      publisher = double(publish: nil)
      ZooStream.publisher = publisher

      event, data, linked, shard_by = double, double, double, double
      ZooStream.publish(event: event, data: data, linked: linked, shard_by: shard_by)
      expect(publisher).to have_received(:publish).with(event: event, data: data, linked: linked, shard_by: shard_by.to_s)
    end

    it 'sets the default shard to the event type itself' do
      publisher = double(publish: nil)
      ZooStream.publisher = publisher

      event, data, linked, shard_by = double("Event"), double, double, double
      ZooStream.publish(event: event, data: data, linked: linked)
      expect(publisher).to have_received(:publish).with(event: event, data: data, linked: linked, shard_by: event.to_s)
    end
  end
end
