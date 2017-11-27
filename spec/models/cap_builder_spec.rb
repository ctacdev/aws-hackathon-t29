RSpec.describe CapBuilder do
  describe "#generate_message" do
    let(:attributes) do
      file = File.read(File.expand_path("docs/cap_alert.json", Rails.root))
      JSON.parse(file).with_indifferent_access
    end

    it 'creates a valid CAP alert' do
      alert = CapBuilder.new.generate_message(attributes)
      expect(alert.valid?).to be true
    end

    it 'sets the references in the alert' do
      alert = CapBuilder.new.generate_message(attributes)
      expect(alert.references).not_to be_empty
    end

    it 'splits references on whitespace' do
      attributes['alert']['references'] = "trinet@caltech.edu,TRI13970876.1,2003-06-11T20:30:00-07:00 trinet2@caltech.edu,TRI2,2003-06-12T20:30:00-07:00"
      alert = CapBuilder.new.generate_message(attributes)
      expect(alert.references.count).to eq 2
    end
  end
end
