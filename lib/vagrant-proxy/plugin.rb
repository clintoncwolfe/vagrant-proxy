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

        # BEGIN workaround
        #
        # Currently hooks attached to {Vagrant::Action::Builtin::Provision} are
        # not wired into the middleware return path. My current workaround is to
        # fire after anything boot related which wedges in right before the
        # actual real run of the provisioner.

        hook.after(VagrantPlugins::ProviderVirtualBox::Action::Boot, Action.setup_proxying)

        # END workaround

      end

      action_hook(:setup_proxying, :machine_action_up, &method(:provision))
      action_hook(:setup_proxying, :machine_action_provision, &method(:provision))

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
