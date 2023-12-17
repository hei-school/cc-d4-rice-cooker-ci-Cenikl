require_relative 'Exception/empty_basket'
require_relative 'Exception/it_is_cooking'
require_relative 'Exception/lid_is_open'
require_relative 'Exception/missing_ingredients'
require_relative 'Exception/no_more_rice'
require_relative 'Exception/no_more_water'
require_relative 'Exception/no_more_space'
require_relative 'Exception/not_plugged_in'
require_relative 'Exception/too_much_rice'
require_relative 'Exception/too_much_water'

class RiceCooker
  def initialize
    @storage_rice = 0
    @storage_water = 0
    @ingredients_basket = []
    @power_on = false
    @lid_closed = true
    @keep_warm_mode = false
    @is_heating = false
    @is_under_pressure = false
    @is_warm = false
    @timer = 0
  end 

  def display_options
    puts "1 - Plug In/Plug Out"
    puts "2 - Open/Close"
    puts "3 - Keep Warm Mode On/Off"
    puts "4 - Check Status Light"
    puts "5 - Put Ingredients in the Main Storage"
    puts "6 - Put Ingredients in the Steaming Basket"
    puts "7 - Set the Timer"
    puts "8 - Stop the Timer"
    puts "9 - Exit"
  end

  def main_menu
    loop do
      display_options
      print "Select an option: "
      option = gets.chomp.to_i

      case option
      when 1
        plug_in_plug_out
      when 2
        open_close
      when 3
        keep_warm_mode
      when 4
        check_status_light
      when 5
        ingredients_storage_menu
      when 6
        steaming_basket_menu
      when 7
        set_timer
      when 8
        stop_timer  
      when 9
        exit_program
      else
        puts "Invalid option. Please try again."
      end
    end
  end

  def plug_in_plug_out
    begin
      raise ITISCOOKING if @timer > 0
      @power_on = !@power_on
      @is_heating = !@is_heating
      puts "Rice cooker is now plugged #{@power_on ? 'in' : 'out'}."
    rescue ITISCOOKING => e
      puts "Error: #{e.message}"
    end 
    
  end

  def open_close
    begin
      raise ITISCOOKING if @timer > 0
      @lid_closed = !@lid_closed
    puts "Rice cooker is now #{@lid_closed ? 'closed' : 'open'}."
    rescue ITISCOOKING => e
      puts "Error: #{e.message}"
    end 
  end

  def keep_warm_mode
    @keep_warm_mode = !@keep_warm_mode
    puts "Keep Warm Mode is now #{@keep_warm_mode ? 'On' : 'Off'}."
  end

  def check_status_light
    if @is_heating == true then
      puts "Rice Cooker is heating now"
    elsif @is_under_pressure == true then
      puts "Rice Cooker is under pressure now"
    elsif @is_warm == true then
      puts "Rice Cooker is now warm" 
    else 
      puts "Rice cooker is off"
    end
  end

  def ingredients_storage_menu
    loop do
      puts "1 - Put Rice in the Storage"
      puts "2 - Remove Rice from the Storage"
      puts "3 - Put Water in the Storage"
      puts "4 - Remove Water from the Storage"
      puts "5 - Check Inside"
      puts "6 - Exit"
      print "Select an option: "
      option = gets.chomp.to_i

      case option
      when 1
        put_rice_in_storage
      when 2
        remove_rice_from_storage
      when 3
        put_water_in_storage
      when 4
        remove_water_from_storage
      when 5
        check_inside
      when 6
        break
      else
        puts "Invalid option. Please try again."
      end
    end
  end

  def put_rice_in_storage
    print "Enter the amount of rice to put in the storage (kg): "
    amount = gets.chomp.to_f
    @storage_rice += amount
    begin
      raise TooMuchRice if @storage_rice > 10
      puts "#{amount} kg of rice is now in the storage."
    rescue TooMuchRice => e
      @storage_rice -= amount
      puts "Error: #{e.message}"
    end
  end

  def remove_rice_from_storage
    print "Enter the amount of rice to remove from the storage (kg): "
    amount = gets.chomp.to_f
    begin
      raise NoMoreRice if amount <= @storage_rice
      @storage_rice -= amount
      puts "#{amount} kg of rice is removed from the storage."
    rescue NoMoreRice => e
      puts "Error: #{e.message}"
    end
  end

  def put_water_in_storage
    print "Enter the amount of water to put in the storage (L): "
    amount = gets.chomp.to_f
    @storage_water += amount
    begin
      raise TooMuchWater if @storage_water > 10
      puts "#{amount} L of water is now in the storage."
    rescue TooMuchWater => e
      @storage_water -= amount
      puts "Error: #{e.message}"
    end
  end

  def remove_water_from_storage
    print "Enter the amount of water to remove from the storage (L): "
    amount = gets.chomp.to_f
    begin
      raise NoMoreWater if amount <= @storage_water
      @storage_water -= amount
      puts "#{amount} L of water is removed from the storage."
    rescue NoMoreWater => e
      puts "Error: #{e.message}"
    end
  end

  def check_inside
    puts "Inside the rice cooker: "
    puts "Rice in Storage: #{@storage_rice} kg"
    puts "Water in Storage: #{@storage_water} L"
    puts "Ingredients in Steaming Basket: #{@ingredients_basket.join(', ')}"
  end

  def steaming_basket_menu
    loop do
      puts "1 - Put Ingredients in it"
      puts "2 - Remove Ingredients"
      puts "3 - Check Inside"
      puts "4 - Exit"
      print "Select an option: "
      option = gets.chomp.to_i

      case option
      when 1
        put_ingredients_in_basket
      when 2
        remove_ingredients_from_basket
      when 3
        check_inside_basket
      when 4
        break
      else
        puts "Invalid option. Please try again."
      end
    end
  end

  def put_ingredients_in_basket
    print "Enter the ingredient to put in the steaming basket: "
    ingredient = gets.chomp
    begin
      raise NoMoreSpace if @ingredients_basket.length() > 3
      @ingredients_basket << ingredient
      puts "#{ingredient} is now in the steaming basket."
    rescue NoMoreSpace => e
      puts "Error: #{e.message}"
    end
  end

  def remove_ingredients_from_basket
    print "Enter the ingredient to remove from the steaming basket: "
    ingredient = gets.chomp
    begin
      raise EmptyBasket if @ingredients_basket.length() == 0
      raise MissingIngredients if @ingredients_basket.include?(ingredient) == false
      @ingredients_basket.delete(ingredient)
      puts "#{ingredient} is removed from the steaming basket."
    rescue EmptyBasket => e
      puts "Error: #{e.message}"
    end
  end

  def check_inside_basket
    puts "Inside the steaming basket: "
    puts "Ingredients: #{@ingredients_basket}"
  end

  def set_timer
    if @storage_rice > 0 || @ingredients_basket.length() > 0 then
      begin
        raise NotPluggedInError if @power_on == false
        raise LidIsOpen if @LidIsOpen == true
        raise NoMoreWater if @storage_water == 0
        print "Enter the timer value (minutes): "
        @timer = gets.chomp.to_i
        puts "Timer is set to #{@timer} minutes."
        @is_heating = true
        countdown_Timer(@timer*60)
      rescue NotPluggedInError => e
        puts "Error: #{e.message}"
      rescue LidIsOpen => e
        puts "Error: #{e.message}"
      rescue NoMoreWater => e
        puts "Error: #{e.message}"  
      end
    end
    puts "There is nothing inside"  
  end

  def stop_timer
    @timer = 0
  end

  def countdown_Timer(seconds)
    @is_heating = false
    @is_under_pressure = true
    Thread.new do
      while seconds > 0
        sleep(1)
        seconds -= 1
      end
    puts "\rTime's up"
    @is_under_pressure = false
    @is_warm = true
    @timer = 0    
    end
  end    

  def exit_program
    puts "Exiting the rice cooker program. Goodbye!"
    exit
  end
end

# Create an instance of the RiceCooker class and start the program
rice_cooker = RiceCooker.new
rice_cooker.main_menu
