class Cast
    attr_accessor :show_id, :act_name, :act_char
    @@all = []

    def initialize(show_id:, act_name:, act_char:)
        @show_id = show_id
        @act_name = act_name
        @act_char = act_char
        show = find_show(@show_id)
        show.cast << self
        @@all << self
    end

    def self.all
        @@all
    end

    def find_show(id)
        Show.all.find { |s| s.show_id == id}
    end
end