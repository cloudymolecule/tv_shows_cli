class Cast
    attr_accessor :show_id, :act_name, :act_char
    @@all = []

    def initialize(show_id:, act_name:, act_char:)
        @show_id = show_id
        @act_name = act_name
        @act_char = act_char
        Show.find_show(@show_id).cast << self
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_cast(id)
        @@all.find { |cast| cast.show_id == id }
    end

end