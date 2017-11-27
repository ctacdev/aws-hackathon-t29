module Api::V1
  RSpec.describe CapAlertsController do
    describe "POST #create" do
      context "with valid attributes" do
        it 'creates a new cap alert' do
          valid_cap_alert = {
            cap_alert: {
              identifier: "test_alert"
            }
          }

          request_headers = {
            "Accept" => "application/json",
            "Content-Type" => "application/json"
          }

          request.headers.merge! request_headers

          allow(CapBuilder).to receive(:from_json)
          post :create, params: valid_cap_alert
        end
      end
    end
  end
end
