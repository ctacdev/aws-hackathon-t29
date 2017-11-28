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
        info.add_parameter do |parameter|
          parameter.name = "EventID"
          parameter.value = "13970876"
        end
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
  end

  def self.generate_from_form(cap_form)
    alert = RCAP::CAP_1_2::Alert.new do |alert|
      alert.sender   = cap_form.sender
      alert.status   = cap_form.status
      alert.msg_type = cap_form.message_type
      alert.scope    = cap_form.scope

      alert.add_info do |info|
        info.event       = cap_form.info_event
        info.language    = cap_form.info_language
        cap_form.info_categories.each do |cat|
          info.categories << cat  if !cat.empty?
        end
        info.urgency     = cap_form.info_urgency
        info.severity    = cap_form.info_severity
        info.certainty   = cap_form.info_certainty
        info.headline    = cap_form.info_headline
        info.description = cap_form.info_description
        info.add_area do |area|
          area.area_desc = cap_form.area_description

          if cap_form.area_geocode_name.present? && cap_form.area_geocode.present?
            area.add_geocode do |geocode|
              geocode.name  = cap_form.area_geocode_name
              geocode.value = cap_form.area_geocode
            end
          end

          if cap_form.area_circle_lattitude.present? && cap_form.area_circle_longitude.present?
            area.add_circle do |circle|
              circle.lattitude = cap_form.area_circle_lattitude
              circle.longitude = cap_form.area_circle_longitude
              circle.radius = "100"
            end
          end
        end
      end
    end
  end

  def self.send_message_to_slack_form_form(cap_form)
    alert = generate_from_form(cap_form)
    HistoricalCap.create(data: alert.to_xml)
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

  def self.send_direct(record)
    #alert = generate_message(record)
    http = Net::HTTP.new("hooks.slack.com", 443)
    http.use_ssl = true
    path = '/services/T029DN528/B85URMY59/MoEesEuZjd1Dy2XBbeCG08I8'
    data = '{ "text" : "' + record + '"}'
    headers = {'Content-Type'=> 'application/json'}

    resp, data = http.post(path, data, headers)

    puts 'Code = ' + resp.code
    puts 'Message = ' + resp.message
    resp.each {|key, val| puts key + ' = ' + val}
    puts data

  end
end
