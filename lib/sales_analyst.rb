require 'pry'
require_relative 'statistic_functions'
class SalesAnalyst
attr_accessor :merchants_repository, :items_repository

def initialize(merchants_repository,items_repository)
	@merchants_repository, @items_repository = merchants_repository,items_repository
end

def average_items_per_merchant
	result=@items_repository.all.count/@merchants_repository.all.count.to_f

	#binding.pry
	result.round(2)
end

def average_items_per_merchant_standard_deviation
	
	average=average_items_per_merchant

	sum_sqaured_diff=0

	@merchants_repository.all.each do |mercahnt|

		sum_sqaured_diff+= (@items_repository.find_all_by_merchant_id(mercahnt.id).count-average)**2
		
	end

	result = (sum_sqaured_diff/(@merchants_repository.all.count.to_f-1))**0.5

	result.round(2)

end


def merchants_with_high_item_count()
		standart_deviation=average_items_per_merchant_standard_deviation
		
		average=average_items_per_merchant
		
		result=@merchants_repository.all.select do |mercahnt|
		
		@items_repository.find_all_by_merchant_id(mercahnt.id).count-standart_deviation>average

	end
	
	result
end

def average_item_price_for_merchant(mercahnt_id)

	mercahnts_items=@items_repository.find_all_by_merchant_id(mercahnt_id)

	numer_of_items=mercahnts_items.count	

	sum_prices=mercahnts_items.inject(0){|sum, item| sum+item.unit_price}

	result=sum_prices/numer_of_items

	result.round(2)


	
end

def average_average_price_per_merchant
	
	average_for_merchant=->(mercahnt_id){average_item_price_for_merchant(mercahnt_id)}

	merchants=@merchants_repository.all.count

	sum_of_averages=@merchants_repository.all.inject(0) do |sum, mercahnt| 
		sum+average_for_merchant.call(mercahnt.id)  

		#binding.pry
	end

	result=sum_of_averages/merchants

	result.round(2)

end


def golden_items
	
end
end

