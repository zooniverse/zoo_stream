require 'aws-sdk'

module ZooStream
  class KinesisPublisher
    attr_reader :stream_name, :client

    def initialize(stream_name: ENV.fetch("ZOO_STREAM_KINESIS_STREAM_NAME"), client: Aws::Kinesis::Client.new)
      @stream_name = stream_name
      @client = client
    end

    def publish(event, shard_by: nil)
      raise ArgumentError, "Must specify shard_by" unless shard_by
      
      client.put_record(
        stream_name: stream_name,
        partition_key: shard_by,
        data: event.to_json
      )
    end
  end
end
