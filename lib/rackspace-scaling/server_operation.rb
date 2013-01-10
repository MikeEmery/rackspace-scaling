module Rackspace
  module Scaling
    class ServerOperation
      def initialize(auth)
        @auth = auth
        @server_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/servers"
        @flavor_endponit = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/flavors"
        @image_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/images"
      end
      
      def list_images
        @image_list ||= begin
          resp = Typhoeus::Request.get(@endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
        end
      end
      
      def list_flavors
      end
      
      def 
    end
  end
end