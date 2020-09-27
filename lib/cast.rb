class Cast
    attr_accessor :act_name, :act_char
    @@all = []

    def initialize(act_name:, act_char:)
        @act_name = act_name
        @act_char = act_char
        @@all << self
    end

    def self.all
        @@all
    end
end