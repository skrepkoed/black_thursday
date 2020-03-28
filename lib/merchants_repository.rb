require 'date'
require_relative 'merchant.rb'
require 'pry'

class MerchantsRepository

attr_accessor :merchants

def initialize(path)
	@merchants= Merchant.list(path)
end

def all
	@merchants
end

def find_by_id(id)

	result=@merchants.select{|merchant| merchant.id==id}

	result[0]
	
end

def find_by_name(name)

	result=@merchants.select{|merchant| merchant.name==name}

	if result.empty?
		result=@merchants.select{|merchant| merchant.name==name.downcase}		
	end

	result[0]
	
end

def find_all_by_name(fragment)

	result=@merchants.find_all{|merchant| merchant.name.match? /#{fragment}/i }

	result
	
end

def create(attributes)

	id=@merchants.last.id+1
	
	
	@merchants<<Merchant.new(name:attributes[:name],id:id)

	#binding.pry
end

def update(id, attributes)

	merchant=self.find_by_id(id)

	attributes.each do |k,v|

		unless k==:id

		sym_method=(k.to_s + '=').to_sym

		merchant.send sym_method, v
	end
	end
end

def delete(id)
	
	@merchants.delete_if{|merchant| merchant.id==id}
end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end