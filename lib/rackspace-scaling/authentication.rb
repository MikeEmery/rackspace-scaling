
module Rackspace
  module Scaling
    class Authentication
      
      attr_reader :user_name
      
      ENDPOINT = 'https://identity.api.rackspacecloud.com/v2.0/tokens'
      
      def initialize(username, api_key)
        @user_name = username
        @payload = {
          :auth => {
            "RAX-KSKEY:apiKeyCredentials" => {
              'username' => username,
              'apiKey' => api_key
            }
          }
        }
      end
      
      def authenticate
        @authenticated ||= begin
          resp = Typhoeus::Request.post(ENDPOINT, :body => @payload.to_json, :headers => {'Content-Type' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
          @token = parsed_response['access']['token']['id']
          @service_catalog = {}
          
          parsed_response['access']['serviceCatalog'].each do |entry|
            @service_catalog[entry['name']] = {
              'type' => entry['type'],
              'endpoints' => {}
            }
            
            entry['endpoints'].each do |endpoint|
              @service_catalog[entry['name']]['endpoints'][endpoint['region']] = endpoint
            end
          end
          
          true
        end
      end
      
      def endpoints
        authenticate
        @service_catalog
      end
      
      def token
        authenticate
        @token
      end
      
    end # /Authentication
  end
end