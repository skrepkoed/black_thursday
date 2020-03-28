require 'csv'

module CsvParser

	def self.included(base)

		base.extend ClassMethods

	end

	module ClassMethods

		def list(path)
			list=[]
			klass=->{self}
			converter=->(x){x.to_sym}
			CSV.read(path, headers:true, header_converters: converter).each do |item|

				list<<klass.call.new(item.to_h)
			end
			return list
		end

	end

end
