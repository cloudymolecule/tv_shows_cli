class CLI #=> responsible for user interaction
    #attr_accessor :input_year, :input_month, :input_day
    def start
        puts ""
        puts "WELCOME TO TV SHOWS FINDER"
        puts ""
        CLI.date_acquire
        
        # input = "#{input_year}-#{input_month}-#{input_day}"
        # binding.pry
    end

    def self.date_acquire #=> gets date and formats it for API
        puts "Please enter a year:"
        input_y = gets.strip
        until input_y.length == 4 && input_y.to_i != 0
            puts ""
            puts "Incorrect format. Please enter a year:"
            input_y = gets.strip   
        end

        puts "Please enter a month:"
        input_m = gets.strip.downcase
        input_m = CLI.month_check(input_m)
        until input_m.to_i >= 1 && input_m.to_i <= 12
            puts ""
            puts "Incorrect format. Please enter a month:"
            input_m = gets.strip.downcase
            input_m =CLI.month_check(input_m)
            #binding.pry
            
        end
        
    end

    def self.month_check(string)
        month = ""
        case string
        when "january"
            month = "01"
        when "february"
            month = "02"
        when "march"
            month = "03"
        when "april"
            month = "04"
        when "may"
            month = "05"
        when "june"
            month = "06"
        when "july"
            month = "07"
        when "august"
            month = "08"
        when "september"
            month = "09"
        when "october"
            month = "10"
        when "november"
            month = "11"
        when "december"
            month = "12"
        else
            month = string
        end
        #binding.pry
        month
    end

end

