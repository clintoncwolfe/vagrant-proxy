module VagrantPlugins
  module Proxy < Vagrant.plugin("2")
    name "Vagrant Proxy plugin - proxy guest HTTP requests"

    config "proxy" do 
      require_relative "config"
      Config
    end

    command "proxy" do
      require_relative "command"
      Command
    end
      
    action "proxy" do
      require_relative "action"
      Action
    end
  
  end
end
