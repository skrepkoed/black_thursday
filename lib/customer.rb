
require 'csv'
require 'time'
require_relative 'csv_parser.rb'

class Customer
class<<self 

	def repository
		:customers_repository
	end
	end

attr_accessor  :id, :first_name, :last_name, :created_at, :updated_at,:total_entities
include CsvParser

def initialize(id:, first_name:, last_name:, created_at:Time.now,updated_at:Time.now)
	@id=id.to_i
	@first_name=first_name
	@last_name=last_name
	@total_entities=Hash.new{|h,k| h[k]=[]}
unless created_at.instance_of? (Time) || updated_at.instance_of?(Time)
	@created_at= Time.parse(created_at)
	@updated_at = Time.parse(updated_at)	
	
else
	
	@created_at=created_at
	@updated_at=updated_at
	end


end

def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


end