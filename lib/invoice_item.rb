require 'bigdecimal/util'
require 'time'
require_relative 'item.rb'
require_relative 'sales_engine.rb'
require 'pry'
class InvoiceItem<Item 

attr_accessor :quantity, :merchant_id, :invoice_id, :item_id 

class<<self 

	def repository
		:invoice_items_repository
	end
attr_accessor :associated_entity

	end

include CsvParser

def self.create_associated_entity

	@@associated_entity||=SalesEngine.items

	#binding.pry
	
end

def initialize(id:,name:nil,description:nil, unit_price:,invoice_id:,item_id:, quantity:, merchant_id:nil, created_at:Time.now,updated_at:Time.now)
	super(id:id,name:name,description:description,unit_price:unit_price,merchant_id:merchant_id, created_at:created_at, updated_at:updated_at)

	InvoiceItem.create_associated_entity
	associated_entity=@@associated_entity.find_by_id(item_id.to_i)
	@name= associated_entity.name
	@description =  associated_entity.description
	@merchant_id = associated_entity.merchant_id
	@owner_model={invoices:invoice_id.to_i,items:item_id.to_i,merchants:merchant_id.to_i}
	@quantity=quantity.to_i
	@invoice_id=invoice_id.to_i
	@item_id=item_id.to_i
	
	
	
end


end