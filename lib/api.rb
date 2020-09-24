class API #=> responsible for getting data from API
    
    def self.grab_shows(date)
        url = "http://api.tvmaze.com/schedule?country=US&date=#{date}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        binding.pry
    end
end