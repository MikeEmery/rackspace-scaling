#!/usr/bin/env ruby
require 'rackspace-scaling'

auth = Rackspace::Scaling::Authentication.new('sparqme', '3e794c248d41e84ee49d80d9ec871714')
puts auth.token
puts auth.endpoints
puts ""

lb = Rackspace::Scaling::LoadBalancer.new(auth, 'DFW')
puts lb.list
