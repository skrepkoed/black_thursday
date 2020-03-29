require 'csv'
require 'time'
require_relative 'csv_parser.rb'

class Merchant
attr_accessor  :id, :name, :created_at, :updated_at
include CsvParser

def initialize(id:,name:,created_at:Time.now,updated_at:Time.now)
	@id, @name, @created_at, @updated_at = id.to_i, name ,created_at,updated_at
end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


end

