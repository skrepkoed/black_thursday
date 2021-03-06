
require 'date'
require_relative 'invoice.rb'
require 'pry'
require_relative 'sales_engine'
require_relative 'basic_functions'

class InvoicesRepository

include BasicFunctions

def initialize(path)
	
	@path=path
	@all=[]
	@included_class=Invoice

	#self.last_id_set(@all)

	#@total_entities=total
end

def initialize_objects_from_csv
	if all.empty?
			
		Invoice.list(@path)

		self.last_id_set(@all)

		@total_entities=total

	end
end

def find_all_by_customer_id(id)

	@all.select{|invoice| invoice.customer_id==id}
	
end

def find_all_by_merchant_id(id)

	@all.select{|invoice| invoice.merchant_id==id}
	
end

def find_all_by_status(status)

	@all.select{|invoice| invoice.status==status}
	
end

def find_all_by_date(date)

	@all.select { |invoice| invoice.created_at==date  }
	
end

end