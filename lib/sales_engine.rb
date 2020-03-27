require 'csv'

class SalesEngine
attr_accessor :merchants, :items

def self.from_csv(paths)
@items=paths[:items]

@merchants=paths[:merchants]
	
end

end