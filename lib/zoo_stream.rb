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
  def self.publish(event: nil, data: nil, linked: {}, shard_by: nil)
    raise ArgumentError, "Must specify event" unless event
    raise ArgumentError, "Must specify data" unless data

    return unless publisher
    event = Event.new(source, event, data, linked)
    publisher.publish(event, shard_by: (shard_by || event.type).to_s)
  end

  def self.publisher
    @publisher || default_publisher
  end

  def self.publisher=(publisher)
    @publisher = publisher
  end

  def self.source
    @source || ENV.fetch("ZOO_STREAM_SOURCE")
  end

  def self.source=(source)
    @source = source
  end

  def self.default_publisher
    if ENV.key?("ZOO_STREAM_KINESIS_STREAM_NAME")
      ZooStream::KinesisPublisher.new
    end
  end
end
