require 'csv'
require_relative 'sales_engine'
module CsvParser

	def self.included(base)

		base.extend ClassMethods

	end

	module ClassMethods

		def list(path)
			
			klass=->{self}
			converter=->(x){x.to_sym}
			CSV.read(path, headers:true, header_converters: converter).each do |item|
					#binding.pry
				SalesEngine.send(klass.call.repository).create(item.to_h)
				#binding.pry
			end
			
		end

	end

end
