require 'csv'

require_relative 'csv_parser.rb'

class Merchant
attr_accessor  :id, :name, :created_at, :updated_at
include CsvParser

def initialize(id:,name:,created_at:,updated_at:)
	@id, @name, @created_at, @updated_at = id,name,created_at,updated_at
end

end