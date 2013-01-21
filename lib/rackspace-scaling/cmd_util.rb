module Rackspace
  module Scaling
    module CmdUtil
      
      def find_instance_by_ip(target_ip, server_list)
        server_list.each do |server|
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
      
      def find_image_by_name(name, images)
        images.sort!{ |a, b| b['created'] <=> a['created']}
        found_image = nil

        images.each do |image|
          if(image['name'] == name)
            found_image = image
            break
          end
        end
        
        found_image
      end
      
    end
  end
end