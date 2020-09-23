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
        input_m_string = gets.strip.downcase
        input_m_int = input_m_string.to_i

        
        until input_m.to_i >= 1 && input_m.to_i <= 12 
            puts ""
            puts "Incorrect format. Please enter a month:"
            input_m = gets.strip.downcase
            
        end

    end

end

# if input_m == "january" || input_m == "1" || input_m == "01"
#     input_m = "01"
# elsif input_m == "february"
#     input_m = "02"
# elsif input_m == "march"
#     input_m = "03"
# elsif input_m == "april"
#     input_m = "04"
# elsif input_m == "may"
#     input_m = "05"
# elsif input_m == "june"
#     input_m = "06"
# elsif input_m == "july"
#     input_m = "07"
# elsif input_m == "august"
#     input_m = "08"
# elsif input_m == "september"
#     input_m = "09"
# elsif input_m == "october"
#     input_m = "10"
# elsif input_m == "november"
#     input_m = "11"
# elsif input_m == "december"
#     input_m = "12"
# end
