require 'csv'
require 'date'
require_relative 'csv_parser.rb'

class Merchant
attr_accessor  :id, :name, :created_at, :updated_at
include CsvParser

def initialize(id:,name:,created_at:Date.today.to_s,updated_at:Date.today.to_s)
	@id, @name, @created_at, @updated_at = id.to_i, name ,created_at,updated_at
end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


end

