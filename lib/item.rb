require 'bigdecimal/util'
require 'time'
require 'pry'
class Item

class<<self 

	def repository
		:items_repository
	end
	end

include CsvParser

attr_accessor  :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :total_entities, :owner_model


def initialize(id:,name:,description:,unit_price:,merchant_id:,created_at:Time.now,updated_at:Time.now)
	@id=id.to_i
	@name= name
	@description = description  
	@unit_price =  BigDecimal(unit_price.to_i,4)/100
	@merchant_id = merchant_id.to_i
	@owner_model={merchants:merchant_id.to_i}
	@total_entities=Hash.new{|h,k| h[k]=[]}
	unless created_at.instance_of? (Time) || updated_at.instance_of?(Time)
	@created_at= Time.parse(created_at)
	@updated_at = Time.parse(updated_at)	
	
else
	
	@created_at=created_at
	@updated_at=updated_at
	end
	
	
end

def unit_price_to_dollars
	@unit_price.to_f
end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end