require 'csv'
 data = CSV.read("2015_registration.csv", { encoding: "iso-8859-1:UTF-8", headers: true, header_converters: :symbol, converters: :all})
hashed_data = data.map { |d| d.to_hash }
hashed_data.each do |reg|
	puts reg[:name].strip
end


