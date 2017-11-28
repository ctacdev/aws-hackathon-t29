require 'net/http'

module Slack
  def self.post_to_channel(msg)
    http = Net::HTTP.new("hooks.slack.com", 443)
    http.use_ssl = true
    path = '/services/T029DN528/B85URMY59/MoEesEuZjd1Dy2XBbeCG08I8'
    data = '{ "text" : "' + msg + '"}'
    headers = {'Content-Type'=> 'application/json'}

    resp, data = http.post(path, data, headers)
  end
end
