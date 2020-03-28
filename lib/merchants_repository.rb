
require './lib/merchant.rb'

class MerchantsRepository

attr_accessor :merchants

def initialize(path)
	@merchants =Merchant.list(path)
end
end