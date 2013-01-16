module Rackspace
  module Scaling
    class ServerOperation
      def initialize(auth, region = 'DFW')
        @auth = auth
        @server_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/servers"
        @flavor_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/flavors"
        @image_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/images"
      end
      
      def list_images
        @image_list ||= begin
          resp = Typhoeus::Request.get(@image_endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
        end
      end
      
      def list_flavors
        @flavor_list ||= begin
          resp = Typhoeus::Request.get(@flavor_endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
        end
      end
      
      def create(options = {})
        create_options = {
          :server => {
            'name' => options[:name],
            'imageRef' => options[:image_id],
            'flavorRef' => options[:flavor_id] 
          }
        }
        puts create_options.to_json
        resp = Typhoeus::Request.post(@server_endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json', 'Content-Type' => 'application/json'}, :body => create_options.to_json)
        parsed_response = JSON.parse(resp.body)
      end
      
      def delete
      end
      
      def list_servers
        @server_list ||= begin
          resp = Typhoeus::Request.get(@server_endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
        end
      end
    end # /ServerOperation
  end
end