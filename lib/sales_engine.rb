require 'csv'
require 'pry'
require_relative 'merchants_repository.rb'
require_relative 'items_repository.rb'
require_relative 'sales_analyst'
class SalesEngine
class<<self

attr_accessor :merchants_path, :merchants_repository, :items_path, :items_repository, :sales_analyst

end
def self.from_csv(paths)

	@merchants_path=paths[:merchants]

	@items_path=paths[:items]
	return self
end



def self.merchants

	@merchants_repository||=MerchantsRepository.new(@merchants_path)
	
	@merchants_repository.initialize_objects_from_csv

	return @merchants_repository
	#binding.pry

end

def self.items
	
	@items_repository||=ItemsRepository.new(@items_path)

	@items_repository.initialize_objects_from_csv
#binding.pry

	return @items_repository

end

def self.analyst 
merchants
items
merchants,items=merchants_repository,items_repository
#binding.pry
SalesAnalyst.new(merchants,items)

end



end