module VagrantPlugins
  module Proxy
    module Action
      class ConfigGuestIpTablesForProxy

        def initialize(app, env)
          @app = app
          # Config#finalize! SHOULD be called automatically
          env[:global_config].omnibus.finalize!
        end


        # (2013-04-27 16:35:42) newgoliath: http://pastebin.com/D0McquR1
        # (2013-04-27 17:05:08) hanskreuger: sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 3128
        # (2013-04-27 17:06:12) juliancdunn: s/3128/8123
        # (2013-04-27 17:19:59) juliancdunn: hanskreuger: is this helpful? http://www.tldp.org/HOWTO/TransparentProxy-6.html
        # (2013-04-27 17:28:54) hanskreuger: sudo iptables -t nat -I OUTPUT --src 0/0  -p tcp --dport 80 -j DNAT --to 10.0.2.2:8123

        def call(env)
          # foo = env[:global_config].proxy.foo

          env[:ui].info("Setting up iptables in guest for proxying... ")
          env[:ssh_run_command] = make_iptables_command(env[:global_config].proxy)

          @app.call(env)
        end

        private
        def make_iptables_command(conf)
          # lalalala idempodency lalalala
          cmd = ""
          cmd << "sudo iptables -t nat -L -n | grep vagrant-proxy > /dev/null "
          cmd << " || "
          cmd << "sudo "
          cmd << "iptables "
          cmd << "-t nat "
          cmd << "-I OUTPUT "
          cmd << "--src 0/0 "
          cmd << "-p tcp "
          cmd << "--dport 80 "
          cmd << "-j DNAT "
          cmd << "-m comment --comment vagrant-proxy "  # We use this to detect the rule
          cmd << "--to 10.0.2.2:8123" # TODO - parameterize from conf          
          cmd << ""
        end

      end
    end
  end
end
