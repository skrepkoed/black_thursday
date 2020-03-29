require 'csv'
require 'pry'
require_relative 'merchants_repository.rb'
require_relative 'items_repository.rb'

class SalesEngine
attr_accessor :merchants_path, :merchants_repository, :items_path, :items_repository

def self.from_csv(paths)
#@items=paths[:items]

#@merchants=CSV.read(paths[:merchants], headers:true headers_converter: :to_sym).each do
	@merchants_path=paths[:merchants]

	@items_path=paths[:items]
	return self
end

def self.merchants

	@merchants_repository||=MerchantsRepository.new(@merchants_path)
	
	#binding.pry

end

def self.items
	@items_repository||=ItemsRepository.new(@items_path)
end

end