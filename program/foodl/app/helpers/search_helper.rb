module SearchHelper
	#Formats a value nicely, with fractions
	def format_quantity( value )
		#Remove everything below .##
		value = (value * 100).round() / 100.0;
		
		#Check for common fractions
		fracs = Hash[ 0.25=>"1/4", 0.33=>"1/3", 0.5=>"1/2", 0.66=>"2/3", 0.75=>"3/4" ]
		if fracs.has_key?( value )
			return fracs[ value ]
		else
			#find amount of decimals to display
			decimal0 = value.round();
			decimal1 = (value * 10 ).round();
			if( decimal0 == value )
				return decimal0.to_s.gsub( ".", "," );
			elsif( decimal1 == value )
				return decimal1.to_s.gsub( ".", "," );
			else
				return value.to_s.gsub( ".", "," );
				#TODO: hide decimal if large numbers?
			end
		end
	end
	
	def has_favour?( id )
		if current_user
			return id_match?( current_user.favorites, id )
		end
		return false
	end
	
	def plural( number, singular, plural )
		return number == 1 ? singular : plural
	end
	
	def id_match?( array, id )
		if array
			array.each do |a|
				if a.id == id
					return true
				end
			end
		end
		return false
	end
end
