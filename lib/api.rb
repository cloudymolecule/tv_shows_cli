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

    def self.grab_cast(id)
        url = "http://api.tvmaze.com/shows/#{id}/cast"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        cast = JSON.parse(response)
        if cast == []
            Cast.new(
                show_id: id,
                act_name: "none",
                act_char: "none"
                )
        else
            cast.each do |cazt|
                Cast.new(
                    show_id: id,
                    act_name: cazt["person"]["name"], #=> actor/actress name
                    act_char: cazt["character"]["name"] #=> actor/actress character
                )
            end
        end
    end
end
