Gem::Specification.new do |s|
  s.name        = 'hexsafe'
  s.summary     = 'Hexsafe Ruby SDK'
  s.version     = '0.0.0'
  s.description = 'A Ruby library to help you to integrate Hexsafe Wallet Management into your rails application'
  s.summary     = 'A Ruby library to help you to integrate Hexsafe Wallet Management into your rails application'
  s.authors     = %w[imrahulprajapat]
  s.email       = 'hashtagrahulprajapat@gmail.com'
  s.files       = Dir['{spec,lib}/**/*'] + %w[LICENSE README.md]
  s.homepage    = 'http://www.hypertechblog.com'
  s.license       = 'MIT'
  s.files       = ["lib/hexsafe.rb", "lib/hexsafe/api.rb"]

  s.add_runtime_dependency 'faraday', ['~> 0.14.0']
  # s.add_runtime_dependency 'ffi'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'openssl'
  s.add_development_dependency 'uri'
  s.add_development_dependency 'base64'
  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end