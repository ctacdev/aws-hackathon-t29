module Api::V1
  class CapAlertsController < ActionController::API

    def create
      cap_alert = CapAlert.create cap_alert_params
      render json: cap_alert, status: :created
    end

    def cap_alert_params
      params.require(:cap_alert).permit(:identifier)
    end

  end
end
