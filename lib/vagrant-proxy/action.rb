require "vagrant/action/builder"

module VagrantPlugins
  module Proxy
    module Action
      include Vagrant::Action::Builtin
      
      # autoload :SetupProxyOnHost, File.expand_path("../action/setup_proxy_on_host", __FILE__)
      autoload :ConfigGuestIpTablesForProxy, File.expand_path("../action/config_guest_iptables_for_proxy", __FILE__)
      autoload :IsRunningOrActive, File.expand_path("../action/is_running_or_active", __FILE__)

      def self.setup_proxying
        @setup_proxying ||= ::Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call,  IsRunningOrActive do |env1, b2|
            if env1[:result]
              # b2.use SetupProxyOnHost
              b2.use ConfigGuestIpTablesForProxy
            end          
          end
        end
      end

    end
  end
end
