module Rackspace
  module Scaling
    class LoadBalancerOperation
      def initialize(auth, region = 'DFW')
        @auth = auth
        @endpoint = @auth.endpoints['cloudLoadBalancers']['endpoints'][region]['publicURL']+"/loadbalancers"
      end

      def list
        @list ||= begin
          resp = Typhoeus::Request.get(@endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
        end
      end
      
      def images(load_balancer_id)
        path = "#{@endpoint}/#{load_balancer_id}/nodes"
        @images ||= begin
          resp = Typhoeus::Request.get(path, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
          parsed_response = JSON.parse(resp.body)
        end
      end
      
      def add_node(options = {})
        load_balancer_id = options[:load_balancer_id]
        body = {
          :nodes => [
            {
              :address => options[:node_ip],
              :port => (options[:port] || 80),
              :condition => (options[:condition] || 'ENABLED'),
              :type => (options[:type] || 'PRIMARY')
            }
          ]
        }
        path = "#{@endpoint}/#{load_balancer_id}/nodes"
        resp = Typhoeus::Request.post(path, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json', 'Content-Type' => 'application/json'}, :body => body.to_json)
        JSON.parse(resp.body)
      end
      
      def remove_node(options = {})
        load_balancer_id = options[:load_balancer_id]
        node_id = options[:node_id]
        path = "#{@endpoint}/#{load_balancer_id}/nodes/#{node_id}"
        resp = Typhoeus::Request.delete(path, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
        resp.success?
      end
      
    end # /LoadBalancerOperation
  end
end
