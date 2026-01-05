require 'net/http'
require 'uri'
require 'json'

if ENV['KAMAL_SLACK_APP_TOKEN']
  SLACK_TOKEN = ENV['KAMAL_SLACK_APP_TOKEN']
else
  require_relative './secrets'
  SLACK_TOKEN = SECRETS['KAMAL_SLACK_APP_TOKEN']
end

def post_slack_message(channel, message)
  uri = URI.parse('https://slack.com/api/chat.postMessage')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.request_uri, {
    'Content-Type': 'application/json',
    'Authorization': "Bearer #{SLACK_TOKEN}"
  })

  request.body = {
    channel: channel,
    text:    message
  }.to_json

  http.request(request)
end
