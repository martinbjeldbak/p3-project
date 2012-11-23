module SearchHelper
	#Formats a value nicely, with fractions
	def format_quantity( value )
		value = (value * 100).round() / 100.0;
		
		#Check for common fractions
		if( value == 0.25 )
			return "1/4";
		elsif( value == 0.33 )
			return "1/3";
		elsif( value == 0.5 )
			return "1/2";
		elsif( value == 0.66 )
			return "2/3";
		elsif( value == 0.75 )
			return "3/4";
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
end
