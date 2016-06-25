require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    
    def initialize
        @address_book = AddressBook.new
    end
    
    def main_menu
        puts "Main Menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - Create an entry"
        puts "3 - Search for an entry"
        puts "4 - Import entries from a CSV"
        puts "5 - View Entry Number n"
        puts "6 - Exit"
        print "Enter your selection: "
        
        selection = gets.to_i
        
        case selection
            when 1
                system "clear" 
                view_all_entries
                main_menu
            when 2
                system "clear"
                create_entry
                main_menu
            when 3
                system "clear" 
                search_entries
                main_menu
            when 4 
                system "clear"
                read_csv
                main_menu
            when 5
                system "clear"
                view_number
                main_menu
            when 6
                puts "Good-bye!"
                exit(0)
            else
                system "clear"
                puts "Sorry, that is not a valid input"
                main_menu
        end
    end
    
    def view_number
        print "Input entry number "
        entry = gets.chomp.to_i
        
        if entry < @address_book.entries.count
            puts @address_book.entries[entry]
            puts "Press enter to return to the main menu"
            gets.chomp
            system "clear"
        else
            puts "#{entry} is no a valid input"
            view_number
        end
    end
    
    def view_all_entries
        
        address_book.entries.each do |entry|
            system "clear"
            puts entry.to_s
            
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end
    
    def create_entry
        system "clear"
        puts "New AddressBloc Entry"
        puts "Name: "
        name = gets.chomp
        puts "Phone number: "
        phone = gets.chomp
        puts = "Email " 
        email = gets.chomp
        
        address_book.add_entry(name, phone, email)
        
        system "clear" 
        puts "New entry created"
    end
    
    def search_entries
    end
    
    def read_csv
        print "Enter CSV file to import: "
        file_name = gets.chomp
        
        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end
        
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
        puts "{file_name} is not a valid CSV file, please enter the name of avalid CSV file"
        read_csv
        end
    end
    
    
    def entry_submenu(entry)
            puts "n - next entry"
            puts "d - delete entry"
            puts "e - edit this entry"
            puts "m - return to main menu"
            
            selection = gets.chomp
            
            case selection
            when "n"
            when "d"
            when "e"
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                entry_submenu(entry)
            end
    end
    
    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
    end
end