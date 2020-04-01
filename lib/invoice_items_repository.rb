

require 'date'
require_relative 'invoice_item.rb'
require 'pry'
require_relative 'sales_engine.rb'
require_relative 'basic_functions'

class InvoiceItemsRepository

include BasicFunctions

def initialize(path)
	
	@path=path
	@all=[]
	@included_class=InvoiceItem

	#self.last_id_set(@all)

	#@total_entities=total
end

def initialize_objects_from_csv
	if all.empty?
			
		InvoiceItem.list(@path)

		self.last_id_set(@all)

		@total_entities=total

	end
end

def find_all_by_item_id(id)

	result=@all.find_all{|entity| entity.item_id==id }

	result
	
end

def find_all_by_invoice_id(id)
	
	result=@all.find_all{|entity| entity.invoice_id==id }

	result

end


end