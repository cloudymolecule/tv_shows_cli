class CLI #=> responsible for user interaction
    #attr_accessor :api_date

    def start
        puts "__________________________"
        puts ""
        puts "WELCOME TO TV SHOWS FINDER"
        puts "__________________________"
        @api_date = CLI.date_acquire
        API.grab_shows(@api_date)
        puts ""
        shows = Show.all
        print_shows(shows)
        puts "Type a show number to get more info, or type 'exit' to exit the application."
    end

    def self.date_acquire #=> gets date and formats it for API
        puts ""
        puts "Please enter a year between 1950 and #{Time.new.year}:"
        input_y = gets.strip
        until input_y.length == 4 && input_y.to_i != 0 && input_y.to_i >= 1950 && input_y.to_i <= Time.new.year 
            puts ""
            puts "Incorrect format. Please enter a year between 1950 and #{Time.new.year}:"
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
        end
        
        puts "Please enter a day of the month:"
        input_d = gets.strip
        until input_d.length >= 1 && input_d.length <= 2  && input_d.to_i != 0 && input_d.to_i <= 31
            puts ""
            puts "Incorrect format. Please enter a day of the month:"
            input_d = gets.strip   
        end
        if input_m.length == 1
            input_m = "0#{input_m}"
        end
        if input_d.length == 1
            input_d = "0#{input_d}"
        end
        api_date = "#{input_y}-#{input_m}-#{input_d}"
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
    def print_shows(shows)
        n_date = @api_date.split("-")
        normal_date = []
        normal_date << n_date[1]
        normal_date << n_date[2]
        normal_date << n_date[0]
        normal_date = normal_date.join("/")
        puts ""
        puts "Here's a list of all TV shows aired on #{normal_date} in the USA"
        ago = Time.new.year - n_date[0].to_i
        puts "That was #{ago} years ago, time surely flies!"
        puts ""
        shows.each.with_index(1) do |s, i|
            puts "#{i} - #{s.show_name}"
        end
        puts ""
    end
end

