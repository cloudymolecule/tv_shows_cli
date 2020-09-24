class API 
    
    def self.grab_shows(date) #=> responsible for getting data from the API by date 
        url = "http://api.tvmaze.com/schedule?country=US&date=#{date}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        shows = JSON.parse(response)
        shows.each do |show|
            Show.new(
                show_id: show["show"]["id"], #=> show id
                ep_name: show["name"], #=> episode name
                show_name: show["show"]["name"], #=>show name
                ep_sum: show["summary"], #=>episode summary
                show_sum: show["show"]["summary"] #=>show summary
                )
        end
        
    end
end
