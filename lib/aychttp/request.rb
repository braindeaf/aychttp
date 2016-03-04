module AychTTP
  class Request
    require 'faraday'
    require 'typhoeus'
    require 'typhoeus/adapters/faraday'

    module Methods
      def get(url, additional_params = {})
        host_with_scheme, path, params = host_path_params(url)
        conn = connection(host_with_scheme)
        response = conn.get(path, params.merge(additional_params))
        Response.new response
      end

      def post(url, addition_params = {})
        host_with_scheme, path, params = host_path_params(url)
        conn = connection(host_with_scheme)
        response = conn.post(path, params.merge(additional_params))
        Response.new response
      end

      private

      def host_path_params(url)
        uri = URI.parse(url)
        [
          ["#{uri.scheme}://#{uri.host}", uri.port].join(':'),
          uri.path,
          URI.decode_www_form(uri.query || '').to_h
        ]
      end

      def connection(url)
        connection = Faraday.new(url: url) do |faraday|
          faraday.adapter :typhoeus
        end
      end
    end
  end
end
