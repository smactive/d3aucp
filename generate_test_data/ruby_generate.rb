
def geo_near(lat, lng)
  @tryagain = true
  10.times do
  	print ".".yellow
    @latitude = lat + rand(0..0.60000000)-0.3
    @longitude = lng + rand(0..0.600000000)-0.3
    location_data = Geocoding.search_by_coords(@latitude, @longitude)
    @streetaddress = location_data["formatted_address"]
    location_data["address_components"].each do |data|
      data["types"].each do |type|
        case type
          when "street_number"
            @tryagain = false
        end
      end
    end
    return location_data["geometry"]["location"].values.to_s unless @tryagain
  end
end

returnArray = []

300.times do |h|
  print ".".green
  returnArray << {
    "event_timestamp": h.hours.ago.utc,
    "event_location": geo_near(-33.87255348, 151.21024132)
  }
end

File.open("opens.json", "w+") do |f|
  f.write(returnArray.to_json)
end
