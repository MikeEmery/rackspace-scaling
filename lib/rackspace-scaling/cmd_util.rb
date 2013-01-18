module Rackspace
  module Scaling
    module CmdUtil
      
      def find_instance_by_ip(target_ip, server_list)
        puts target_ip

        server_list['servers'].each do |server|
          server['addresses'].each do |k, v|
            v.each do |ip|
              if(ip['addr'] == target_ip)
                return server
              end
            end
          end
        end

        nil
      end
      
    end
  end
end