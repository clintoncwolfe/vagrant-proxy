# -*-ruby-*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-proxy/version'

Gem::Specification.new do |gem|
  gem.name          = "vagrant-proxy"
  gem.version       = VagrantPlugins::Proxy::VERSION
  gem.authors       = ["Clinton Wolfe"]
  gem.email         = ["clinton@omniti.com"]
  gem.description   = %q{A plugin to proxy HTTP requests made by the Vagrant provisioner, using the TBD proxy kit.}
  gem.summary       = %q{A plugin to proxy HTTP requests made by the Vagrant provisioner.}
  gem.homepage      = "https://github.com/clintoncwolfe/vagrant-proxy"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
