module Api::V1
  RSpec.describe CapAlertsController do
    describe "POST #create" do
      let(:request_headers) do
        {
          "Accept" => "application/json",
          "Content-Type" => "application/json"
        }
      end
      before(:each) { request.headers.merge! request_headers }

      context "with valid attributes" do
        let(:valid_cap_alert) do
          {
            cap_alert: {
              identifier: "test_alert"
            }
          }
        end

        it 'creates a new cap alert' do
          allow(CapBuilder).to receive(:from_json)
          post :create, params: valid_cap_alert
        end

        it 'responds with a 201 CREATED' do
          post :create, params: valid_cap_alert
          expect(response).to have_http_status(:created)
        end
      end # with valid attributes

      context "with invalid attributes" do

      end
    end
  end
end
