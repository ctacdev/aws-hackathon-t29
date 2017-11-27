require 'rcap'
require 'net/http'
require 'uri'

class CapBuilder


  def self.generate_message
    alert = RCAP::CAP_1_2::Alert.new do |alert|
      alert.sender   = 'cape_town_disaster_relief@capetown.municipal.za'
      alert.status   = RCAP::CAP_1_2::Alert::STATUS_ACTUAL
      alert.msg_type = RCAP::CAP_1_2::Alert::MSG_TYPE_ALERT
      alert.scope    = RCAP::CAP_1_2::Alert::SCOPE_PUBLIC 

      alert.add_info do |info|
        info.event       = 'Liquid Petroleoum Tanker Fire'
        info.language    = 'en-ZA'
        info.categories  << RCAP::CAP_1_2::Info::CATEGORY_TRANSPORT
        info.categories  << RCAP::CAP_1_2::Info::CATEGORY_FIRE 
        info.urgency     = RCAP::CAP_1_2::Info::URGENCY_IMMEDIATE
        info.severity    = RCAP::CAP_1_2::Info::SEVERITY_SEVERE
        info.certainty   = RCAP::CAP_1_2::Info::CERTAINTY_OBSERVED
        info.headline    = 'LIQUID PETROLEOUM TANKER FIRE ON N2 INCOMING FREEWAY'
        info.description = 'A liquid petroleoum tanker has caught fire on the N2 incoming freeway 1km after the R300 interchange.  Municipal fire fighting crews have been dispatched. Traffic control officers are on the scene and have diverted traffic onto alternate routes.' 
        info.add_area do |area|
          area.area_desc = 'N2 Highway/R300 Interchange' 
          area.add_geocode do |geocode|
            geocode.name  = 'Intersection'
            geocode.value = 'N2-15' 
          end
        end
      end
    end

    return alert
  end

  def generate_message(record)
    #this one should take the actual model and do interesting things
  end

  def self.send_message_to_slack(record)
    alert = generate_message
    #alert = generate_message(record)
    http = Net::HTTP.new("hooks.slack.com", 443)
    http.use_ssl = true
    path = '/services/T029DN528/B85URMY59/MoEesEuZjd1Dy2XBbeCG08I8'
    data = '{ "text" : "' + alert.to_xml + '"}'
    headers = {'Content-Type'=> 'application/json'}

    resp, data = http.post(path, data, headers)

    puts 'Code = ' + resp.code
    puts 'Message = ' + resp.message
    resp.each {|key, val| puts key + ' = ' + val}
    puts data
   
  end
end