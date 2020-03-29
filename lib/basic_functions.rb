

module BasicFunctions

def all
	@all
end


def find_by_id(id)

	result=@all.select{|entity| entity.id==id}

	result[0]
	
end

def find_by_name(name)

	result=@all.select{|entity| entity.name==name}

	if result.empty?
		result=@all.select{|entity| entity.name==name.downcase}		
	end

	result[0]
	
end

def find_all_by_name(fragment)

	result=@all.find_all{|entity| entity.name.match? /#{fragment}/i }

	result
	
end

def create(attributes)
	attributes[:id]=last_id_get+1
	@all<<@included_class.new(attributes)

	#binding.pry
end

def update(id, attributes)

	entity=self.find_by_id(id)
	if entity
		attributes[:updated_at]=Time.now
			attributes.each do |k,v|

				unless k==:id||k==:created_at||k.match?(/_id\z/)

				sym_method=(k.to_s + '=').to_sym

				entity.send sym_method, v
				end
			end
	end
end

def delete(id)
	
	@all.delete_if{|entity| entity.id==id}
end

	def inspect
	    "#<#{self.class} #{@all.size} rows>"
	  end

	def last_id_set(all)

		@last_id=all.last.id

	end

	def last_id_get
		
		@last_id
	
	end

end