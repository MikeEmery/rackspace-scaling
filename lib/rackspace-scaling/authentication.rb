module Rackspace
  module Scaling
    class Authentication
      
      ENDPOINT = 'https://identity.api.rackspacecloud.com/v2.0/tokens'
      
      def initialize(username, api_key)
        @payload = {
          :auth => {
            "RAX-KSKEY:apiKeyCredentials" => {
              'username' => username,
              'apiKey' => api_key
            }
          }
        }
      end  
    end
    
    def token
      resp = Typhoeus.post(ENDPOINT, :params => @payload.to_json, :headers => {'Content-Type' => 'application/json'})
    end
  end
end