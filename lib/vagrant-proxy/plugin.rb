module VagrantPlugins
  module Proxy

    autoload :Action, 'vagrant-proxy/action'

    class Plugin < Vagrant.plugin("2")
      name "vagrant-proxy"
      description "Vagrant Proxy plugin - proxy guest HTTP requests"
     
      config "proxy" do 
        require_relative "config"
        Config
      end

      def self.provision(hook)
        hook.before(Vagrant::Action::Builtin::Provision, Action.setup_proxying)
      end

      action_hook(:setup_proxying, :machine_action_up, &method(:provision))

      #command "proxy" do
      #  require_relative "command"
      #  Command
      #end
      
      #action "proxy" do
      #  require_relative "action"
      #  Action
      #end

    end

  end
end
