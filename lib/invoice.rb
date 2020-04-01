
require 'csv'
require 'time'
require_relative 'csv_parser.rb'

class Invoice
class<<self 

	def repository
		:invoices_repository
	end
	end

attr_accessor  :id, :status, :customer_id, :merchant_id, :created_at, :updated_at ,:total_entities
include CsvParser

def initialize(id:,status:, customer_id:, merchant_id:, created_at:Time.now,updated_at:Time.now)
	@id=id.to_i
	@status= status.to_sym 
	@customer_id=customer_id.to_i
	@merchant_id=merchant_id.to_i 
	@total_entities=Hash.new(0)
	unless created_at.instance_of? (Time) || updated_at.instance_of?(Time)
	@created_at= Time.parse(created_at)
	@updated_at = Time.parse(updated_at)	
	
else
	
	@created_at=created_at
	@updated_at=updated_at
	end

	#!!!!!@total_entities=0



end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


end