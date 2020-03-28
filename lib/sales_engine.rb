require 'csv'
require 'pry'
require_relative 'merchants_repository.rb'


class SalesEngine
attr_accessor :merchants_path, :merchants_repository, :items

def self.from_csv(paths)
#@items=paths[:items]

#@merchants=CSV.read(paths[:merchants], headers:true headers_converter: :to_sym).each do
	@merchants_path=paths[:merchants]
	return self
end

def self.merchants

	@merchants_repository||=MerchantsRepository.new(@merchants_path)
	
	#binding.pry

end

end