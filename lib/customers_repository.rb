

require 'date'
require_relative 'customer.rb'
require 'pry'
require_relative 'sales_engine'
require_relative 'basic_functions'

class CustomersRepository

include BasicFunctions



def initialize(path)
	
	@path=path
	@all=[]
	@included_class=Customer

	#self.last_id_set(@all)

	#@total_entities=total
end

def initialize_objects_from_csv
	if all.empty?
			
		Customer.list(@path)

		self.last_id_set(@all)

		@total_entities=total

	end
end

def find_all_by_first_name(first_name)
	
	result=@all.find_all{|entity| entity.first_name.downcase.match? /#{first_name}/i }

	result


end


def find_all_by_last_name(last_name)
	
	result=@all.find_all{|entity| entity.last_name.downcase.match? /#{last_name}/i }

	result


end


end