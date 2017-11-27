module Api::V1
  class CapAlertsController < ActionController::API
    def create
      cap_alert = CapBuilder.new.generate_message(cap_alert_params)
      render json: {body: cap_alert.to_xml}, status: :created
    end

    private

    def cap_alert_params
      params.require(:cap_alert).permit!
    end

  end
end
