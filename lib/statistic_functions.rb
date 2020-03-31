

module StatisticFunctions

def average(values:, number_of_values:)

	sum_of_values=values.inject(0){|sum, value| sum+value}

	result=sum_of_values/number_of_values.to_f

	result.round(2)
	
end

def standard_deviation(set_of_values:)

	average=average(values:set_of_values, number_of_values:set_of_values.count)

	sum_of_squares=set_of_values.inject(0){|sum,value|  sum+(average-value)**2}

	result=(sum_of_squares/(set_of_values.count-1).to_f)**0.5

	{result: result.round(2), average:average}

	
end

def standard_deviation_evaluation


end

end