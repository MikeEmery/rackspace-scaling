class LoadBalancer
  def initialize(auth, region = 'DFW')
    @endpoint = @auth.endpoints[region]['publicURL']
    @auth = auth
  end
  
  def list
    @list ||= begin
      resp = Typhoeus::Request.get(@endpoint, :headers => { 'X-Auth-Token' => @auth.token, 'Accept' => 'application/json'})
      parsed_response = JSON.parse(resp.body)
    end
  end
end