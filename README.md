# Rackspace::Scaling

This gem aims to provide a relatively simple library to increase your number of servers in a rackspace cloud and, optionally, attach those servers to a load balancer.  This gem is pretty low level in relation to the API, and doesn't abstract away much.

Detailed information about the API can be found  here:

http://docs.rackspace.com/servers/api/v2/cs-devguide/content/ch_api_operations.html  
http://docs.rackspace.com/loadbalancers/api/v1.0/clb-devguide/content/API_Operations-d1e1354.html

There are also official rackspace gems that provide the same functionality available here:

https://github.com/rackspace/ruby-cloudlb  
https://github.com/rackspace/ruby-cloudservers

I didn't know these gems existed when I started work on this project :(

## Installation

Add this line to your application's Gemfile:

    gem 'rackspace-scaling'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rackspace-scaling

## Usage

### Api

The very first thing you need to do is get an authentication token.

    auth = Rackspace::Scaling::Authentication.new('account_name', 'api_key')

You can then perform operations for servers or load balancers.

#### Load Balancers

    lb = Rackspace::Scaling::LoadBalancerOperation.new(auth, 'DFW')

    #list all load balancers
    puts lb.list

    #list all nodes attached to a load balancer
    puts lb.nodes(12345)

    #Add a node to a load balancer, defaults to port 80, can be overriden with the :port option
    puts lb.add_node(:load_balancer_id => 12345, :node_ip => 'internal or external ip')

    #remove a node
    puts lb.remove_node(:load_balancer_id => 12345, :node_id => 67890)
    
#### Servers
    srv = Rackspace::Scaling::ServerOperation.new(auth, 'DFW')

    # lists all the available images you can create servers with
    srv.list_images

    #list flavours (sizes) of machines you can spin up
    srv.list_flavors

    #get the status for a specific instance
    srv.status('server guid')

    #create a new server, required parameters are :image_id, :flavor_id, and :name
    puts = srv.create(:flavor_id => '2', :image_id => 'guid', :name => 'fooserver')

    #destroy a server
    puts srv.destroy('server-guid')

### Command-LIne

You can either increase or decrease the number of servers you have running.  

#### Scale Up

    rackspace_scale_up --api-key myapikey --login mylogin -l 12345 -i server-image-name -n 2

#### Scale Down

    rackspace_scale_down --api-key myapikey --login mylogin -l 12345 -n 2

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
