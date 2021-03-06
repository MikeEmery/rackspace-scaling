module Rackspace
  module Scaling
    class ServerOperation
      def initialize(auth, region = 'DFW')
        @auth = auth
        @server_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/servers"
        @flavor_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/flavors"
        @image_endpoint = @auth.endpoints['cloudServersOpenStack']['endpoints'][region]['publicURL']+"/images"
      end
      
      def list_images(options = {})
        url = "#{@image_endpoint}"
        if(options[:detail])
          url = "#{url}/detail"
        end
        
        @image_list ||= begin
          resp = Typhoeus::Request.get(url, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)['images']
        end
      end
      
      def list_flavors
        @flavor_list ||= begin
          resp = Typhoeus::Request.get(@flavor_endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)['flavors']
        end
      end
      
      def status(server_id)
        url = "#{@server_endpoint}/#{server_id}"
        resp = Typhoeus::Request.get(url, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
        JSON.parse(resp.body)['server']
      end
      
      def create(options = {})
        create_options = {
          :server => {
            'name' => options[:name],
            'imageRef' => options[:image_id],
            'flavorRef' => options[:flavor_id] 
          }
        }
        resp = Typhoeus::Request.post(@server_endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json', 'Content-Type' => 'application/json'}, :body => create_options.to_json)
        parsed_response = JSON.parse(resp.body)['server']
      end
      
      def destroy(guid)
        server_url = "#{@server_endpoint}/#{guid}"
        resp = Typhoeus::Request.delete(server_url, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
        return resp.success?
      end
      
      def list_servers(options = {})
        url = "#{@server_endpoint}"
        
        if(options[:detail])
          url += '/detail'
        end
        
        @server_list ||= begin
          resp = Typhoeus::Request.get(url, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)['servers']
        end
      end
    end # /ServerOperation
  end
end