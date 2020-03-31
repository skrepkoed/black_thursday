require_relative 'basic_functions'
require_relative 'item'
require_relative 'sales_engine'
require 'pry'
require 'bigdecimal'
class ItemsRepository

include BasicFunctions


def initialize(path)
	@path=path

	@all=[]
	@included_class=Item 

end

def initialize_objects_from_csv
	
	if @all.empty?	

		Item.list(@path)
		
		self.last_id_set(@all)

		@total_entities=total

	end
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

def find_all_by_merchant_id(merchant_id, attribute:nil)

	if attribute 
	result=@all.find_all{ |item| item.merchant_id==merchant_id}.map{ |item| item.send(attribute)}
	else
	result=@all.find_all { |item| item.merchant_id==merchant_id  }	
	end
	
	
	result
end

end