class CLI #=> responsible for user interaction

    def start #=> starts the CLI                                                                                                                                                                                      
        welcome_banner
        puts ""
        puts ""
        @api_date = date_acquire
        API.grab_shows(@api_date)
        print_shows(Show.all)
        input = gets.strip.downcase

        while input != "exit" do
            if input == "back"
                print_shows(Show.all)
                puts ColorizedString["TYPE A SHOW NUMBER TO GET MORE INFO, OR TYPE 'exit' TO EXIT THE PROGRAM"].colorize(:yellow)
                puts ""
                puts "awaiting input..."
                input = gets.strip.downcase

            elsif input.to_i <= Show.all.count && input.to_i != 0 && input.to_i >= 1
                @i = input
                print_show_summary(input)
                puts ColorizedString["TYPE:"].colorize(:yellow)
                puts ColorizedString["'episode' to get info on that specific episode"].colorize(:yellow)
                puts ColorizedString["'cast' to see the show's cast"].colorize(:yellow)
                puts ColorizedString["'back' to go back to the shows list for #{date_normalizer}"].colorize(:yellow)
                puts ColorizedString["'exit' to exit the program"].colorize(:yellow)
                puts ""
                puts "awaiting input..."
                input = gets.strip.downcase

            elsif input == "episode" && @i != nil
                    print_episode_summary(@i)
                    puts ColorizedString["TYPE:"].colorize(:yellow)
                    puts ColorizedString["'back' to go back to the shows list for #{date_normalizer}"].colorize(:yellow)
                    puts ColorizedString["'cast' to get the show's cast"].colorize(:yellow)
                    puts ColorizedString["'exit' to exit the program"].colorize(:yellow)
                    puts ""
                    puts "awaiting input..."
                    input = gets.strip.downcase

            elsif input == "cast" && @i != nil
                
                if !Cast.find_cast(Show.all[@i.to_i - 1].show_id)
                    API.grab_cast(Show.all[@i.to_i - 1].show_id)
                    print_cast(Show.all[@i.to_i - 1].cast)
                else
                    print_cast(Show.all[@i.to_i - 1].cast)
                end

                puts ColorizedString["TYPE:"].colorize(:yellow)
                puts ColorizedString["'back' to go back to the shows list for #{date_normalizer}"].colorize(:yellow)
                puts ColorizedString["'exit' to exit the program"].colorize(:yellow)
                puts ""
                puts "awaiting input..."
                input = gets.strip.downcase
            else
                puts ColorizedString["Incorrect input, please try again"].colorize(:red)
                puts ""
                puts "awaiting input..."
                input = gets.strip.downcase
            end
        end
        puts "___________________________________________".colorize(:yellow)
        puts ""
        puts ColorizedString["I HOPE YOU FOUND WHAT YOU WERE LOOKING FOR "].colorize(:color => :yellow, :background => :blue)
        puts ColorizedString["             HAVE A NICE DAY!              "].colorize(:color => :yellow, :background => :blue)
        puts "___________________________________________".colorize(:yellow)
        puts ""
        puts ""
    end

    private
    
    def date_acquire #=> gets date and formats it for API
        puts ""
        puts ColorizedString["PLEASE ENTER A YEAR BETWEEN 1950 AND #{Time.now.year}:"].colorize(:yellow)
        input_y = gets.strip
        until input_y.length == 4 && input_y.to_i != 0 && input_y.to_i >= 1950 && input_y.to_i <= Time.now.year do
            puts ""
            puts ColorizedString["INCORRECT YEAR OR FORMAT. PLEASE ENTER A YEAR BETWEEN 1950 AND #{Time.new.year}:"].colorize(:red)
            puts "awaiting input..."
            input_y = gets.strip   
        end

        puts ColorizedString["PLEASE ENTER A MONTH:"].colorize(:yellow)
        input_m = gets.strip.downcase
        input_m = month_check(input_m)
        if input_y.to_i == Time.now.year
            until input_m.to_i >= 1 && input_m.to_i <= Time.now.month
                puts ""
                puts ColorizedString["INCORRECT MONTH OR FORMAT. PLEASE ENTER A MONTH:"].colorize(:red)
                input_m = gets.strip.downcase
                input_m = month_check(input_m)    
            end
        else
            until input_m.to_i >= 1 && input_m.to_i <= 12
                puts ""
                puts ColorizedString["INCORRECT MONTH OR FORMAT. PLEASE ENTER A MONTH:"].colorize(:red)
                input_m = gets.strip.downcase
                input_m = month_check(input_m)    
            end
        end

        puts ColorizedString["PLEASE ENTER A DAY OF THE MONTH:"].colorize(:yellow)
        input_d = gets.strip
        if input_y.to_i == Time.now.year && input_m.to_i == Time.now.month
            until input_d.length >= 1 && input_d.length <= 2  && input_d.to_i != 0 && input_d.to_i <= Time.now.day
                puts ""
                puts ColorizedString["INCORRECT DAY OR FORMAT. PLEASE ENTER A DAY OF THE MONTH:"].colorize(:red)
                input_d = gets.strip   
            end
        else
            until input_d.length >= 1 && input_d.length <= 2  && input_d.to_i != 0 && input_d.to_i <= 31
                puts ""
                puts ColorizedString["INCORRECT DAY OR FORMAT. PLEASE ENTER A DAY OF THE MONTH:"].colorize(:red)
                input_d = gets.strip   
            end
        end

        if input_m.length == 1
            input_m = "0#{input_m}"
        end
        if input_d.length == 1
            input_d = "0#{input_d}"
        end
        api_date = "#{input_y}-#{input_m}-#{input_d}"
    end                                                                                          
                                                                                                             
    def month_check(string) #=> validates the month's input
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
        when "jan"
            month = "01"
        when "feb"
            month = "02"
        when "mar"
            month = "03"
        when "aug"
            month = "08"
        when "sep"
            month = "09"
        when "oct"
            month = "10"
        when "nov"
            month = "11"
        when "dec"
            month = "12"
        else
            month = string
        end
        month
    end

    def date_normalizer #=> turns API formated date into a readable format for puts
        normal_date = []
        n_date = @api_date.split("-")
        normal_date << n_date[1]
        normal_date << n_date[2]
        normal_date << n_date[0]
        normal_date = normal_date.join("/")
    end

    def print_shows(shows) #=> puts a list of the the TV shows and the episodes aired that day
        if Show.all == []  
            puts ""
            puts "-------------------------------------------------".colorize(:yellow)
            puts ColorizedString[" Sorry, this date doesn't include any shows"].colorize(:red)
            puts ColorizedString["  Please type 'exit' to exit the program"].colorize(:yellow)
            puts "-------------------------------------------------".colorize(:yellow)
            puts ""
        else  
            ago = Time.now.year - date_normalizer.split("/")[2].to_i
            puts ""
            puts "------------------------------------------------------------".colorize(:yellow)
            puts ColorizedString["HERE'S A LIST OF ALL TV SHOWS AIRED ON #{date_normalizer} IN THE USA"].colorize(:light_blue)
            puts ColorizedString["        THAT WAS #{ago} YEARS AGO, TIME SURE FLIES!"].colorize(:light_blue)
            puts "------------------------------------------------------------".colorize(:yellow)
            puts ""
            shows.each.with_index(1) do |s, i|
                puts "#{i} - #{s.show_name} | Episode: '#{s.ep_name}'"
            end
            puts ""
            puts ColorizedString["TYPE A SHOW NUMBER TO GET MORE INFO, OR TYPE 'exit' TO EXIT THE PROGRAM"].colorize(:yellow)
            puts ""
            puts "awaiting input..."
        end
        puts ""
    end

    def print_show_summary(show) #=> puts a specific show's summary
        if Show.all[show.to_i - 1].show_sum == "" || Show.all[show.to_i - 1].show_sum == nil
            puts ""
            puts "---------------------------------------------------".colorize(:yellow)
            puts ColorizedString["    Sorry, this show doesn't include a summary"].colorize(:red)
            puts ColorizedString[" Please type 'back' to go back to the show listing"].colorize(:yellow)
            puts "---------------------------------------------------".colorize(:yellow)
            puts ""
        else
            sh_summary = Show.all[show.to_i - 1].show_sum.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, "")
            puts ""
            puts "--------------------------------------------------------------------------------".colorize(:yellow)
            puts ColorizedString["Show summary: '#{Show.all[show.to_i - 1].show_name}'"].colorize(:light_blue)
            puts "--------------------------------------------------------------------------------".colorize(:yellow)
            width = 80
            puts sh_summary.scan(/\S.{0,#{width}}\S(?=\s|$)|\S+/)
            puts "--------------------------------------------------------------------------------".colorize(:yellow)
            puts ""
        end
    end

    def print_episode_summary(episode) #=> puts a specific episode summary
        if Show.all[episode.to_i - 1].ep_sum == "" || Show.all[episode.to_i - 1].ep_sum == nil
            puts ""
            puts "---------------------------------------------------".colorize(:yellow)
            puts ColorizedString["  Sorry, this episode doesn't include a summary"].colorize(:red)
            puts ColorizedString[" Please type 'back' to go back to the shows listing"].colorize(:yellow)
            puts "---------------------------------------------------" .colorize(:yellow)
            puts ""
        else 
            ep_summary = Show.all[episode.to_i - 1].ep_sum.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, "")
            puts ""
            puts "--------------------------------------------------------------------------------".colorize(:yellow)
            puts ColorizedString["Show: '#{Show.all[episode.to_i - 1].show_name}' | Episode summary: '#{Show.all[episode.to_i - 1].ep_name}'"].colorize(:light_blue)
            puts "--------------------------------------------------------------------------------".colorize(:yellow)
            width = 80
            puts ep_summary.scan(/\S.{0,#{width}}\S(?=\s|$)|\S+/)
            puts "--------------------------------------------------------------------------------".colorize(:yellow)
            puts ""
        end
    end

    def print_cast(cast) #=> puts a specific show cast
        if cast[0].act_name == "none"
            puts ""
            puts ""
            puts "-------------------------------------------------".colorize(:yellow)
            puts ColorizedString["     Sorry, this show doesn't include a cast     "].colorize(:red)
            puts ColorizedString[" Please type 'back' to go back to the shows listing"].colorize(:yellow)
            puts "-------------------------------------------------".colorize(:yellow)
            puts ""
        else
            puts ""
            puts "-----------------------------------------------------------".colorize(:yellow)
            puts ColorizedString["Here's the cast for: '#{Show.all[@i.to_i - 1].show_name}'"].colorize(:light_blue)
            puts "-----------------------------------------------------------".colorize(:yellow)
            puts ""
            cast.each.with_index(1) do |c, i|
                puts "#{i} - NAME: '#{c.act_name}' | CHARACTER: '#{c.act_char}'"
            end
            puts "-----------------------------------------------------------".colorize(:yellow)
        end
    end

    def welcome_banner #=> cherry on top :)
        puts ColorizedString['
        __      __   _                    _                                                     
        \ \    / /__| |__ ___ _ __  ___  | |_ ___                                               
         \ \/\/ / -_) / _/ _ \ `  \/ -_) |  _/ _ \                                              
          \_/\_/\___|_\__\___/_|_|_\___|  \__\___/                                              
         _   _ ___   _     _______   __  ___ _  _  _____      _____   ___ ___ _  _ ___  ___ ___ 
        | | | / __| /_\   |_   _\ \ / / / __| || |/ _ \ \    / / __| | __|_ _| \| |   \| __| _ \
        | |_| \__ \/ _ \    | |  \ V /  \__ \ __ | (_) \ \/\/ /\__ \ | _| | || .` | |) | _||   /
         \___/|___/_/ \_\   |_|   \_/   |___/_||_|\___/ \_/\_/ |___/ |_| |___|_|\_|___/|___|_|_\ '].colorize(:light_blue)
    end
end
