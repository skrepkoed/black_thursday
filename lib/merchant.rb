require 'csv'
require 'time'
require_relative 'csv_parser.rb'

class Merchant
class<<self 

	def repository
		:merchants_repository
	end
	end

attr_accessor  :id, :name, :created_at, :updated_at,:total_entities
include CsvParser

def initialize(id:,name:,created_at:Time.now,updated_at:Time.now)
	@id, @name, @created_at, @updated_at = id.to_i, name ,created_at,updated_at

	@total_entities=0



end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


end

