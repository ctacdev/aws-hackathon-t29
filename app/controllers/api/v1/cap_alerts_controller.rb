module Api::V1
  class CapAlertsController < ActionController::API

    wrap_parameters format: [:json]

    def create
      cap_alert = CapBuilder.from_json(cap_alert_params)
      render json: cap_alert, status: :created
    end

    private

    def cap_alert_params
      params.require(:cap_alert).permit!
    end

  end
end
