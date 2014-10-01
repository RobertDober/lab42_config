$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'lab42/config/version'
version = Lab42::Config::VERSION
Gem::Specification.new do |s|
  s.name        = 'lab42_config'
  s.version     = version
  s.summary     = 'Refactor your configuration code away!'
  s.description = %{Define configuration values with defaults and lazy evaluation on a per class or per instance level} 
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = "https://github.com/RobertDober/lab42_config"
  s.licenses    = %w{MIT}

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'forwarder2', '~> 0.2'

  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'pry-nav', '~> 0.2'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'qed', '~> 2.9'
  s.add_development_dependency 'ae', '~> 1.8'
  # s.add_development_dependency 'lab42_tmux2', '~> 0.0'
  s.add_development_dependency 'travis-lint', '~> 2.0'
  # s.add_development_dependency 'rake', '~> 10.3'
end
