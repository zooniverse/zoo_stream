module ZooStream
  class Event
    attr_reader :source, :type, :data, :linked, :timestamp

    def initialize(source, type, data, linked, timestamp: Time.now)
      @source, @type, @data, @linked, @timestamp = source, type, data, linked, timestamp
    end

    def to_h
      {
        source: source,
        type: type,
        version: '1.0.0',
        timestamp: timestamp.utc.iso8601,
        data: data,
        linked: linked
      }
    end

    def to_json
      to_h.to_json
    end
  end
end
