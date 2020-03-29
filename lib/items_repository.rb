require_relative 'basic_functions'
require_relative 'item'
require 'pry'
require 'bigdecimal'
class ItemsRepository

include BasicFunctions
attr_accessor :all 

def initialize(path)
	@all= Item.list(path)
	@included_class=Item 

	self.last_id_set(@all)
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

	result
end

end