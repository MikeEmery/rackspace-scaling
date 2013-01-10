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
    end # /LoadBalancer
  end
end
