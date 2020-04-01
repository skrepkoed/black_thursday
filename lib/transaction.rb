

require 'bigdecimal/util'
require 'time'
require 'pry'
class Transaction

class<<self 

	def repository
		:transactions_repository
	end
	end

include CsvParser

attr_accessor  :id, :invoice_id, :created_at, :updated_at, :result, :credit_card_expiration_date, :credit_card_number


def initialize(id:,invoice_id:, credit_card_number:, credit_card_expiration_date:,result:, created_at:Time.now,updated_at:Time.now)
	@id=id.to_i
	@invoice_id = invoice_id.to_i
	@credit_card_number=credit_card_number
	@credit_card_expiration_date=credit_card_expiration_date
	@result=result.to_sym
	unless created_at.instance_of? (Time) || updated_at.instance_of?(Time)
	@created_at= Time.parse(created_at)
	@updated_at = Time.parse(updated_at)	
	
else
	
	@created_at=created_at
	@updated_at=updated_at
	end
	
	
end



def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end