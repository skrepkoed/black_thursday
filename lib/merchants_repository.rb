require 'date'
require_relative 'merchant.rb'
require 'pry'

require_relative 'basic_functions'

class MerchantsRepository

include BasicFunctions

attr_accessor :all 

def initialize(path)
	@all= Merchant.list(path)
	@included_class=Merchant

	self.last_id_set(@all)
end



end