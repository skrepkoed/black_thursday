require 'pry'
require_relative 'statistic_functions'

class SalesAnalyst
	attr_accessor :merchants_repository, :items_repository ,:invoices_repository

	include StatisticFunctions

	def initialize(merchants_repository,items_repository,invoices_repository)
		@merchants_repository, @items_repository = merchants_repository,items_repository,invoices_repository
	end

	def average_items_per_merchant
		#result=@items_repository.all.count/@merchants_repository.all.count.to_f

		average(values: @merchants_repository.all_total_entities(:items), number_of_values:@merchants_repository.total)

		#binding.pry
		#result.round(2)
	end

	def average_items_per_merchant_standard_deviation
		
		standard_deviation(set_of_values: @merchants_repository.all_total_entities(:items))[:result]

	end


	def merchants_with_high_item_count()
			standart_deviation=average_items_per_merchant_standard_deviation
			
			average=average_items_per_merchant
			
			result=@merchants_repository.all.select do |merchant|
			
					merchant.total_entities[:items]-standart_deviation>average

					end
		
			result
	end

	def average_item_price_for_merchant(merchant_id)

		number_of_mercahnts_items=@merchants_repository.find_by_id(merchant_id).total_entities[:items]

		merchant_items_priceses=@items_repository.find_all_by_merchant_id(merchant_id, attribute: :unit_price)
		#binding.pry
		average(values:merchant_items_priceses, number_of_values:number_of_mercahnts_items)

	end

	def average_average_price_per_merchant
		
		average_for_merchant=->(mercahnt_id){average_item_price_for_merchant(mercahnt_id)}

		merchants=@merchants_repository.total

		averages_for_merchant=@merchants_repository.all(attribute: :id).inject([]){|result , i| result<<average_for_merchant.call(i)}

		average(values:averages_for_merchant, number_of_values:merchants)


	end


	def golden_items
		average_item_price=average(values:@items_repository.all(attribute: :unit_price), number_of_values:@items_repository.total)
		
		standard_deviation_items_price=standard_deviation(set_of_values: @items_repository.all(attribute: :unit_price))
		
		result=@items_repository.all.select { |item| item.unit_price-2*standard_deviation_items_price>average_item_price }

		result
	
	end

	def average_invoices_per_merchant

		average(values: @merchants_repository.all_total_entities(:invoices), number_of_values: @merchants_repository.total)
		
	end

	def average_invoices_per_merchant_standard_deviation 

		standard_deviation(set_of_values: @merchants_repository.all_total_entities(:invoices))
		
	end

end
