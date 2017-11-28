module Api::V1
  class CapAlertsController < ActionController::API
    def create
      json = underscore_keys(cap_alert_params.to_h).to_json
      cap_alert = RCAP::CAP_1_2::Alert.from_json(json)
      if cap_alert.valid?
        Slack.post_to_channel(cap_alert.to_xml)
        render json: {body: cap_alert.to_xml}, status: :created
      else
        render json: {errors: cap_alert.errors.full_messages}, status: :unprocessable_entity
      end
    end

    private

    def cap_alert_params
      params.require(:alert).permit!
    end

    def underscore_keys(h)
      return nil if h.nil?
      h.dup.each do |key, value|
        if value.kind_of?(Hash)
          h[key] = underscore_keys(value)
        elsif value.kind_of?(Array)
          value.map do |elem|
            if elem.kind_of?(Hash)
              underscore_keys(elem)
            else
              elem
            end
          end
        else
          h.delete(key)
          h[key.underscore] = value
        end
      end
      h
    end

  end
end
