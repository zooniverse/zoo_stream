require 'aws-sdk'

require 'zoo_stream/event'

module ZooStream
  class KinesisPublisher
    attr_reader :source, :stream_name, :client

    def initialize(source:, stream_name: ENV.fetch("KINESIS_STREAM"), client: Aws::Kinesis::Client.new)
      @source = source
      @stream_name = stream_name
      @client = client
    end

    def publish(event:, data:, shard_by:, linked: {})
      client.put_record(
        stream_name: stream_name,
        partition_key: shard_by,
        data: format_data(event, data, linked)
      )
    end

    private

    def format_data(event, data, linked)
      Event.new(source, event, data, linked).to_json
    end
  end
end
