module ZooStream
  class Event
    attr_reader :source, :event, :data, :linked

    def initialize(source, event, data, linked)
      @source, @event, @data, @linked = source, event, data, linked
    end

    def to_h
      {
        source: source,
        type: event,
        version: '1.0.0',
        timestamp: Time.now.utc.iso8601,
        data: data,
        linked: linked
      }
    end

    def to_json
      to_h.to_json
    end
  end
end
