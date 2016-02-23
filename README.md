# ZooStream

Within the Zooniverse backend infrastructure, we run a Kinesis stream so that internal agents can listen to
what's happening inside our applications, calculate stuff on the fly and/or respond to events as they happen.
For instance, [Nero](https://github.com/zooniverse/nero) reacts to classifications and decides when to retire
subjects, while [ZooEventStats](https://github.com/zooniverse/zoo-event-stats) aggregates various statistics that
get published on dashboards like [watch.zooniverse.org](http://watch.zooniverse.org).

## Installation

```ruby
gem 'zoo_stream', '~> 1.0'
```

We follow SemVer.

## Configuration

To publish events on the stream, you'll need to set up AWS roles. In the AWS console, make sure the instance your service
is running on is assigned an IAM role, and attach the "Kinesis-Stream-Writer" managed policy to that role. This will allow the AWS client gem to automatically get credentials with the correct access permissions.

You can either configure this gem using environment variables:

  * For production, set the environment variable `ZOO_STREAM_KINESIS_STREAM_NAME` to `zooniverse-production`
  * For staging, set the environment variable `ZOO_STREAM_KINESIS_STREAM_NAME` to `zooniverse-staging`
  * Set the environment variable `ZOO_STREAM_SOURCE` to the name of your service (keep it lowercased and whitespace-free).

Or programmatically (not recommended):

```ruby
ZooStream.publisher = ZooStream::KinesisPublisher.new(stream_name: "zooniverse-production")
ZooStream.source = "my-application"
```

## Usage

To post an event to the Kinesis stream, call `#publish`. You need to specify the `event` type and the `data` of the event.
Optionally, you can pass in records related to the main data under `linked`, and you can specify the `shard_by` if events
don't need to be processed in globally consistent order, as long as they are ordered within the `shard_by`.

```ruby
ZooStream.publish(event: 'classification',
                  data: {annotations: {}, links: {subject: 1}},
                  linked: {subjects: [{id: 1, metadata: {}}]},
                  shard_by: workflow.id)
```

If you don't set a stream name, **this gem will silently ignore all `#publish` messages**.



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zooniverse/zoo_stream. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

