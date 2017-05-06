# A gemspec is called from a Ruby method — anything you can do in Ruby you can do in a gemspec.
# httparty is a dependency. it provides a programmatic Ruby interface to make HTTP requests.
Gem::Specification.new do |s|
  s.name = 'kele'
  s.version = '0.0.1'
  s.date = '2017-05-05'
  s.summary = 'Kele API Client'
  s.description = 'A client for the Block API'
  s.authors = ['Archita Patel']
  s.email = ['architapatelis@gmail.com']
  s.files = ['lib/kele.rb']
  s.require_paths = ["lib"]
  s.homepage = 'http://rubygems.org/gems/kele'
  s.license = 'MIT'
  s.add_runtime_dependency 'httparty', '~> 0.13'
  s.add_runtime_dependency 'json', '~> 2.1.0'
end
