require 'csv'
require 'pry'
require_relative 'merchants_repository.rb'
require_relative 'items_repository.rb'
require_relative 'invoices_repository.rb'
require_relative 'customers_repository.rb'
require_relative 'invoice_items_repository.rb'
require_relative 'transactions_repository.rb'
require_relative 'sales_analyst'
class SalesEngine
class<<self

attr_accessor :merchants_path, :merchants_repository, :items_path, :items_repository, :invoices_repository, :invoices_path,  :customers_repository, :customers_path,:invoice_items_repository, :invoice_items_path,:transactions_path,:transactions_repository, :sales_analyst

end
def self.from_csv(paths)

	@merchants_path=paths[:merchants]

	@items_path=paths[:items]

	@customers_path=paths[:customers]

	@invoices_path=paths[:invoices]

	@invoice_items_path=paths[:invoice_items]

	@transactions_path=paths[:transactions]

	
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
#binding.pry
	@items_repository.initialize_objects_from_csv
#binding.pry

	return @items_repository

end

def self.invoices
	
	@invoices_repository||=InvoicesRepository.new(@invoices_path)

	@invoices_repository.initialize_objects_from_csv
#binding.pry

	return @invoices_repository

end

def self.customers
	
	@customers_repository||=CustomersRepository.new(@customers_path)

	@customers_repository.initialize_objects_from_csv
#binding.pry

	return @customers_repository

end

def self.invoice_items
	
	@invoice_items_repository||=InvoiceItemsRepository.new(@invoice_items_path)

	@invoice_items_repository.initialize_objects_from_csv
#binding.pry

	return @invoice_items_repository

end

def self.transactions

	@transactions_repository||=TransactionsRepository.new(@transactions_path)

	@transactions_repository.initialize_objects_from_csv

	return @transactions_repository
	
end


def self.analyst 

merchants
items

invoices
customers

invoice_items
transactions

merchants,items,invoices,customers,invoice_items,transactions=merchants_repository,items_repository,invoices_repository,customers_repository,invoice_items_repository,transactions_repository
#binding.pry
SalesAnalyst.new(merchants,items,invoices,customers,invoice_items,transactions)

end



end