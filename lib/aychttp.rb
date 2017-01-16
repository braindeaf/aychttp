require 'aychttp/request'
require 'aychttp/response'
require 'aychttp/version'

module AychTTP
  extend Request::Methods

  module Methods
    def uri_for(args)
      host, port, path = [args.delete(:host), args.delete(:port), args.delete(:path)]
      builder = args.delete(:protocol) == 'https' ? URI::HTTPS : URI::HTTP

      uri = builder.build host: host, port: port, path: path
      unless args.empty?
        uri.query = args.reject { |_k, v| v.nil? }.sort_by { |k, _v| k.to_s }.map { |k, v| "#{k}=#{v.to_s}" }.join('&')
      end
      uri.to_s
    end
  end
  extend Methods
end
