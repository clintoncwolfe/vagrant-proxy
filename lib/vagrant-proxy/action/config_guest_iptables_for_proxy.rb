module VagrantPlugins
  module Proxy
    module Action
      class ConfigGuestIpTablesForProxy

        def initialize(app, env)
          @app = app
          # Config#finalize! SHOULD be called automatically
          env[:global_config].omnibus.finalize!
        end

        def call(env)
          puts "I would TOTES configure iptables in the guest"
        end          
      end
    end
  end
end
