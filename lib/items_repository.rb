require_relative 'basic_functions'
require_relative 'item'
require_relative 'sales_engine'
require 'pry'
require 'bigdecimal'
class ItemsRepository

include BasicFunctions


def initialize(path)
	@all= Item.list(path)
	@included_class=Item 

	self.last_id_set(@all)

	@total_entities=total
end

def find_all_with_description(description)
	

	result=@all.find_all{|entity| entity.description.match? /#{description}/i }

	result
	#binding.pry

end


def find_all_by_price(price)

result=@all.find_all{|entity| entity.unit_price==price}

	result
	
end


def find_all_by_price_in_range(range)
	result=@all.find_all{|entity|  range.include?(entity.unit_price)}

	result
end

def find_all_by_merchant_id(merchant_id)
	result=@all.find_all { |item| item.merchant_id==merchant_id  }
	
	#SalesEngine.merchants_repository.find_by_id(merchant_id).total=result.count

	result
end

end