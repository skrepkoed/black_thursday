require 'bigdecimal/util'
require 'time'
class Item
require 'pry'
include CsvParser

attr_accessor  :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at


def initialize(id:,name:,description:,unit_price:,merchant_id:,created_at:Time.now,updated_at:Time.now)
	@id=id.to_i
	@name= name
	@description = description  
	@unit_price =  BigDecimal(unit_price.to_i,4)/100
	@merchant_id = merchant_id.to_i
	unless created_at.instance_of? (Time) || updated_at.instance_of?(Time)
	@created_at= Time.parse(created_at)
	@updated_at = Time.parse(updated_at)	
	#binding.pry
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