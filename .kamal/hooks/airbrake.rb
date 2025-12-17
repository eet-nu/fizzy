require 'net/http'
require 'json'

KAMAL_ROOT ||= File.expand_path('../../', __FILE__)
RAILS_ROOT ||= File.expand_path('../', KAMAL_ROOT)

def airbrake_installed?
  File.exist?(File.join(RAILS_ROOT, 'Gemfile.lock')) &&
    File.read(File.join(RAILS_ROOT, 'Gemfile.lock')).match?(/^\s+airbrake\s\(/)
end

def notify_airbrake_of_deployment
  return unless airbrake_installed?

  environment = ENV.fetch('KAMAL_ENV',       'production')
  username    = ENV.fetch('KAMAL_PERFORMER', `whoami`.strip)
  repository  = `git config --get remote.origin.url`.strip
  revision    = `git rev-parse HEAD`.strip
  version     = `git describe --tags --always`.strip

  `kamal app exec "rake airbrake:deploy USERNAME=#{username} ENVIRONMENT=#{environment} REVISION=#{revision} REPOSITORY=#{repository} VERSION=#{version}" --roles web --primary`
end
