class Show
    attr_reader :show_id, :ep_name, :show_name, :ep_sum, :show_sum, :cast
    @@all = []

    def initialize(show_id:, ep_name:, show_name:, ep_sum:, show_sum:)
        @show_id = show_id
        @ep_name = ep_name
        @show_name = show_name
        @ep_sum = ep_sum
        @show_sum = show_sum
        @cast = []
        @@all << self 
    end

    def self.all
        @@all
    end
    
    def self.find_show(id)
        @@all.find { |s| s.show_id == id}
    end

    # def self.find_cast
    #     @@all.select { |c| c.cast.length > 1}
    # end
end

