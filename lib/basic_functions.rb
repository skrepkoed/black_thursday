require 'sales_engine'

module BasicFunctions
attr_accessor :all, :total_entities, :path

def all( attribute:nil)
	if attribute

		@all.map { |entity| entity.send(attribute)  }

	else
		@all
	end

	
end

def total
	
	@all.count

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
	if attributes[:id]==nil
		attributes[:id]=last_id_get+1
	end	
	flag={foreign_key:false,primary_key:false}
	entity_name=''
	attributes.each do |k,v|

		if k.to_s.match?(/_id\z/)
			flag[:foreign_key]=true
			entity_name=k.to_s.chomp '_id'

			entity_name+='s_repository'

			entity_name=entity_name.to_sym
			#binding.pry
			primary_key=SalesEngine.send(entity_name).find_by_id(v.to_i)
				#binding.pry 	
			flag[:primary_key]=primary_key.id

				
		end
		
	end
	if flag[:primary_key]&&flag[:foreign_key]
		SalesEngine.send(entity_name).find_by_id(flag[:primary_key]).total_entities+=1
		
		new_entity=@included_class.new(attributes)
			
		@all<<new_entity
	end

	if flag[:foreign_key]==false
		@all<<@included_class.new(attributes)	
	end
	
end

def update(id, attributes)

	entity=self.find_by_id(id)
	if entity
		attributes[:updated_at]=Time.now
			attributes.each do |k,v|

				unless k==:id||k==:created_at||k.match?(/_id\z/)||k==:total

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