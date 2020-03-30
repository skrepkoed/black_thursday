require 'date'
require_relative 'merchant.rb'
require 'pry'
require_relative 'sales_engine'
require_relative 'basic_functions'

class MerchantsRepository

include BasicFunctions



def initialize(path)
	@all= Merchant.list(path)
	
	@included_class=Merchant

	self.last_id_set(@all)

	@total_entities=total
end



end