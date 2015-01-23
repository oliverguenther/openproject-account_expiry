# encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)

require 'open_project/account_expiry/version'
Gem::Specification.new do |s|
  s.name        = 'openproject-account_expiry'
  s.version     = OpenProject::AccountExpiry::VERSION
  s.authors     = ['Oliver Günther']
  s.email       = 'mail@oliverguenther.de'
  s.homepage    = 'https://www.github.com/oliverguenther/openproject-account_expiry'
  s.summary     = 'Account Expiry'
  s.description = 'Extends accounts with an expiry date'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*'] + %w(README.md)
end
