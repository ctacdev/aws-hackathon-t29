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
        let(:cap_alert_json) do
          JSON.parse(File.read(File.expand_path("docs/cap_alert.json", Rails.root)))
        end

        it 'generates a valid cap_alert' do
          json = underscore_keys(cap_alert_json['alert']).to_json
          alert = RCAP::CAP_1_2::Alert.from_json(json)
          alert.valid?
          expect(alert.errors.full_messages).to be_empty
          expect(alert.valid?).to be true
        end

        it 'responds with a 201 CREATED' do
          post :create, body: cap_alert_json.to_json, format: :json
          expect(response).to have_http_status(:created)
        end
      end # with valid attributes

      context "with invalid attributes" do
        let(:invalid_json) do
          {
            alert: {
              identifier: "123"
            }
          }.to_json
        end

        it 'response with a 400 BAD_REQUEST' do
          post :create, body: invalid_json, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
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
