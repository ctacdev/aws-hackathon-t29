class HistoricalCap < ApplicationRecord
  def parse
    RCAP::CAP_1_2::Alert.from_xml(data)
  end
end
