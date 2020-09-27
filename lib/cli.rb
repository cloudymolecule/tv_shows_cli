class CLI #=> responsible for user interaction

    def start #=> initiates the CLI
        puts "__________________________"
        puts ""
        puts "WELCOME TO TV SHOWS FINDER"
        puts "__________________________"
        @api_date = date_acquire
        API.grab_shows(@api_date)
        shows = Show.all
        puts ""
        print_shows(shows)
        puts "TYPE A SHOW NUMBER TO GET MORE INFO, OR TYPE 'EXIT' TO EXIT THE APPLICATION."
        puts "awaiting input..."
        input = gets.strip.downcase
        while input != "exit" do
            if input == "back"
                print_shows(shows)
                puts "TYPE A SHOW NUMBER TO GET MORE INFO, OR TYPE 'EXIT' TO EXIT THE APPLICATION."
                puts "awaiting input..."
                input = gets.strip.downcase
            elsif input.to_i <= Show.all.count && input.to_i != 0 && input.to_i >= 1
                @i = input
                @id = Show.all[@i.to_i - 1].show_id
                print_show_summary(input)
                puts "TYPE:"
                puts "'EPISODE' to get info on that specific episode"
                puts "'CAST' to see the show's cast"
                puts "'BACK' to go back to the show's list for #{date_normalizer}"
                puts "awaiting input..."
                input = gets.strip.downcase
                if input == "episode" && @i != nil
                    print_episode_summary(@i)
                    puts "TYPE:"
                    puts "'BACK' to go back to the show's list for #{date_normalizer}"
                    puts "'CAST' to get the show's cast"
                    puts "awaiting input..."
                    input = gets.strip.downcase
                end
            elsif input == "cast" && @i != nil
                if Show.all[@i.to_i - 1].cast == []
                    API.grab_cast(Show.all[@i.to_i - 1].show_id)
                    cast = Show.all[@i.to_i - 1].cast
                else
                    cast = Show.all[@i.to_i - 1].cast
                end
                
                puts ""
                print_cast(cast)
                puts "awaiting input..."
                input = gets.strip.downcase
            else
                puts "Incorrect input, please try again"
                puts "awaiting input..."
                input = gets.strip.downcase
            end
            
            
        end
    end

    def date_acquire #=> gets date and formats it for API
        puts ""
        puts "PLEASE ENTER A YEAR BETWEEN 1950 AND #{Time.new.year}:"
        puts "awaiting input..."
        input_y = gets.strip
        until input_y.length == 4 && input_y.to_i != 0 && input_y.to_i >= 1950 && input_y.to_i <= Time.new.year do
            puts ""
            puts "INCORRECT YEAR OR FORMAT. PLEASE ENTER A YEAR BETWEEN 1950 AND #{Time.new.year}:"
            puts "awaiting input..."
            input_y = gets.strip   
        end

        puts "PLEASE ENTER A MONTH:"
        puts "awaiting input..."
        input_m = gets.strip.downcase
        input_m = month_check(input_m)
        until input_m.to_i >= 1 && input_m.to_i <= 12
            puts ""
            puts "INCORRECT FORMAT. PLEASE ENTER A MONTH:"
            puts "awaiting input..."
            input_m = gets.strip.downcase
            input_m = month_check(input_m)    
        end
        
        puts "PLEASE ENTER A DAY OF THE MONTH:"
        puts "awaiting input..."
        input_d = gets.strip
        until input_d.length >= 1 && input_d.length <= 2  && input_d.to_i != 0 && input_d.to_i <= 31
            puts ""
            puts "INCORRECT FORMAT. PLEASE ENTER A DAY OF THE MONTH:"
            puts "awaiting input..."
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

    def date_normalizer
        n_date = @api_date.split("-")
        normal_date = []
        normal_date << n_date[1]
        normal_date << n_date[2]
        normal_date << n_date[0]
        normal_date = normal_date.join("/")
        normal_date
    end

    def print_shows(shows) #=> prints a list of the the TV shows and the episodes aired that day
        puts ""
        puts "------------------------------------------------------------"
        puts "HERE'S A LIST OF ALL TV SHOWS AIRED ON #{date_normalizer} IN THE USA."
        ago = Time.new.year - date_normalizer.split("/")[2].to_i
        puts "        THAT WAS #{ago} YEARS AGO, TIME SURE FLIES!"
        puts "------------------------------------------------------------"
        puts ""
        shows.each.with_index(1) do |s, i|
            puts "#{i} - #{s.show_name} | Episode: '#{s.ep_name}'"
        end
        puts ""
    end

    def print_show_summary(show) #=> puts a specific show's summary
        if Show.all[show.to_i - 1].show_sum == "" || Show.all[show.to_i - 1].show_sum == nil
            puts ""
            puts "-------------------------------------------------"
            puts "   Sorry, this show doesn't include a summary."
            puts "Please type 'back' to go back to the show listing"
            puts "-------------------------------------------------"
        else
            sh_summary = Show.all[show.to_i - 1].show_sum.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, "")
            puts "---------------------------------"
            puts "#{Show.all[show.to_i - 1].show_name} | summary:"
            puts "---------------------------------"
            puts sh_summary
            puts ""
        end
    end

    def print_episode_summary(episode)
        if Show.all[episode.to_i - 1].ep_sum == "" || Show.all[episode.to_i - 1].ep_sum == nil
            puts ""
            puts "-------------------------------------------------"
            puts " Sorry, this episode doesn't include a summary."
            puts "Please type 'back' to go back to the show listing"
            puts "-------------------------------------------------" 
        else 
            ep_summary = Show.all[episode.to_i - 1].ep_sum.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, "")
            puts "---------------------------------"
            puts "#{Show.all[episode.to_i - 1].ep_name} | summary:" 
            puts "---------------------------------"
            puts ep_summary
            puts ""
        end
    end

    def print_cast(cast)
        puts ""
        puts "------------------------------------------------------------"
        puts "HERE'S A LIST OF THE CAST FOR: #{Show.all[@i.to_i - 1].show_name.upcase}."
        puts "------------------------------------------------------------"
        puts ""
        cast.each.with_index(1) do |c, i|
            puts "#{i} - NAME: #{c.act_name} | CHARACTER: #{c.act_char}"
            puts "-----------------------------------------------------------"
        end
        puts ""
    end

end
