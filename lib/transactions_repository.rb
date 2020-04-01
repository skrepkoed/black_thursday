

require 'date'
require_relative 'transaction.rb'
require 'pry'
require_relative 'sales_engine'
require_relative 'basic_functions'

class TransactionsRepository

include BasicFunctions



def initialize(path)
	
	@path=path
	@all=[]
	@included_class=Transaction

	#self.last_id_set(@all)

	#@total_entities=total
end

def initialize_objects_from_csv
	if all.empty?
			
		Transaction.list(@path)

		self.last_id_set(@all)

		@total_entities=total

	end
end

def find_all_by_invoice_id(id)
	
	result=@all.find_all{|entity| entity.invoice_id==id }

	result

end

def find_all_by_credit_card_number(number)

	result=@all.find_all{|entity| entity.credit_card_number==number }

	result
end


def find_all_by_result(result)

	result=@all.find_all{|entity| entity.result==result }

	result
	
end

end