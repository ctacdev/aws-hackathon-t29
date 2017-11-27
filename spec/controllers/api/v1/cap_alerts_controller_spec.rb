module Api::V1
  RSpec.describe CapAlertsController do
    def valid_cap_alert
      {
        identifier: "test_alert"
      }
    end
    describe "POST #create" do
      context "with valid attributes" do
        it 'creates a new cap alert' do
          expect {post :create, params: {cap_alert: valid_cap_alert}}.to change {CapAlert.count}
        end

        it 'returns a 201 CREATED' do
          post :create, params: {cap_alert: valid_cap_alert}
          expect(response).to have_http_status(201)
        end

      end
    end
  end
end
