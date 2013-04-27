module VagrantPlugins
  module Proxy
    module Action
      class ConfigGuestIpTablesForProxy
        def call(env)
          puts "I would TOTES configure iptables in the guest"
        end          
      end
    end
  end
end
