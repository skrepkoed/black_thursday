require 'pry'
require_relative 'statistic_functions'

class SalesAnalyst
	attr_accessor :merchants_repository, :items_repository ,:invoices_repository, :customers_repository, :invoice_items_repository, :transactions_repository

	include StatisticFunctions

	def initialize(merchants_repository,items_repository,invoices_repository,customers_repository,invoice_items_repository,transactions_repository)
		@merchants_repository, @items_repository,@invoices_repository,@customers_repository,@invoice_items_repository,@transactions_repository = merchants_repository,items_repository,invoices_repository,customers_repository,invoice_items_repository,transactions_repository
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

		result=standard_deviation(set_of_values: @merchants_repository.all_total_entities(:invoices))[:result]


		
	end

	def top_merchants_by_invoice_count

		container=standard_deviation(set_of_values: @merchants_repository.all_total_entities(:invoices))

		average=container[:average]

		standard_deviation=container[:result]

		@merchants_repository.all.select do |merchant|
				
			merchant.total_entities[:invoices]-2*standard_deviation>average
			
		end
		
	end

	def bottom_merchants_by_invoice_count

		container=standard_deviation(set_of_values: @merchants_repository.all_total_entities(:invoices))

		average=container[:average]

		standard_deviation=container[:result]

		compared1=average-2*standard_deviation
		compared2=average-3*standard_deviation

		range=compared2..compared1

		@merchants_repository.all.select do |merchant|
				
			#merchant.total_entities[:invoices]-1*standard_deviation<average

			range.include?(merchant.total_entities[:invoices])
	
		end


	end

	def top_days_by_invoice_count

		day_of_week={1=>'Monday',2=>'Thuesday', 3=>'Wednesday', 4=>'Thursday', 5=>'Friday', 6=>'Saturday',0=>'Sunday'}
		invoices_per_day_of_week={1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0,0=>0}
		
		
		@invoices_repository.all.each do |i|

			invoices_per_day_of_week[i.created_at.wday]+=1
			#binding.pry
		end
		
		container=standard_deviation(set_of_values: invoices_per_day_of_week.values)

		average=container[:average]

		standard_deviation=container[:result]

		result=invoices_per_day_of_week.select do |day,invoices|
				
			invoices-standard_deviation>average
			
		end		

		result.keys.map{|i|  day_of_week[i]}




	end

	def invoice_status(status)

		invoices_with_status=@invoices_repository.all(attribute: :status).select{|invoice_status| invoice_status==status}.count

		result=(invoices_with_status/@invoices_repository.total_entities.to_f)*100

		result.round(2)
		
	end

	def invoice_paid_in_full?(id)
		!(@transactions_repository.find_all_by_invoice_id(id).select{|i| i.result==:success}.empty?)

		#binding.pry
	end

	def invoice_total(id)

		@invoice_items_repository.find_all_by_invoice_id(id).inject(0) do |sum,i|

			sum+i.quantity*i.unit_price
			
		end


		
	end
end
