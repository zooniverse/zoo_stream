require 'spec_helper'

describe ZooStream::KinesisPublisher do
  let(:aws) { instance_double("Aws::Kinesis::Client", put_record: nil) }

  subject(:publisher) { described_class.new stream_name: 'stream', client: aws }

  describe '#publish' do
    let(:time)  { Time.now }
    let(:event) { ZooStream::Event.new('source', 'test', {}, {}, timestamp: time) }

    it 'puts a record into the aws client' do
      publisher.publish(event, shard_by: 'test')
      event = {source: 'source', type: 'test', version: '1.0.0', timestamp: time.utc.iso8601, data: {}, linked: {}}.to_json
      expect(aws).to have_received(:put_record).with(stream_name: 'stream',
                                                     partition_key: 'test',
                                                     data: event)
    end
  end
end
