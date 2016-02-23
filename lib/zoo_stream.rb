require "zoo_stream/version"
require 'zoo_stream/event'
require "zoo_stream/kinesis_publisher"

module ZooStream
  # Publishes an event
  #
  # @param event [String] the event type
  # @param data [Hash] the event data
  # @param linked [Hash] related models to the data
  # @param shard_by [String] if present, reader order will be guaranteed within this shard. If left blank, the entire stream will always be a single shard.
  def self.publish(event:, data:, linked: {}, shard_by: nil)
    return unless publisher
    event = Event.new(source, event, data, linked)
    publisher.publish(event, shard_by: (shard_by || event.type).to_s)
  end

  def self.publisher
    @publisher
  end

  def self.publisher=(publisher)
    @publisher = publisher
  end

  def self.source
    @source
  end

  def self.source=(source)
    @source = source
  end
end
