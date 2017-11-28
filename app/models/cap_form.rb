require 'rcap'
require 'net/http'
require 'uri'

class CapForm
  include ActiveModel::Model
  @data = []

  attr_accessor(:sender,
    :status,
    :message_type,
    :scope,
    :info_event,
    :info_language,
    :info_categories,
    :info_urgency,
    :info_severity,
    :info_certainty,
    :info_headline,
    :info_description,
    :area_description,
    :area_geocode_name,
    :area_geocode,
    :area_circle_lattitude,
    :area_circle_longitude
    )

end
