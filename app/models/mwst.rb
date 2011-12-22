module Mwst
  Percent = 19.0
  # for a given netto price will return the included mwst
  def self.included_in( netto )
    ( (netto*Percent) / (Percent + 100.0) ).round(2)
  end
end
