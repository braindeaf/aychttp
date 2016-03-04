module AychTTP
  # Response object that parses JSON
  class Response
    def initialize(response)
      @response = response
    end

    def status
      @response.status
    end

    def body
      @response.body
    end

    def parsed_body
      return @parsed_body if defined? @parsed_body
      @parsed_body = JSON.parse(@response.body)
    end

    def [](key)
      parsed_body[key]
    end

    def to_s
      parsed_body
    end
  end
end
