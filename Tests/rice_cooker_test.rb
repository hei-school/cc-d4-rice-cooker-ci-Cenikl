require_relative '../rice_cooker'
require_relative '../Exception/it_is_cooking'
require 'rspec'


describe "Testing the rice cooker power" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should be plugged in" do
        expect{@rice_cooker.plug_in_plug_out}.to output(/Rice cooker is now plugged in./).to_stdout
    end
    it "should be plugged out" do
        @rice_cooker.instance_variable_set(:@power_on,true)
        expect{@rice_cooker.plug_in_plug_out}.to output(/Rice cooker is now plugged out./).to_stdout
    end
    it "should raise TimerIsOn error" do
        @rice_cooker.instance_variable_set(:@timer,5)
        expect{@rice_cooker.plug_in_plug_out}.to output("Error: You cant unplug now, the timer is on\n").to_stdout
    end
end

describe "Testing the rice cooker's lid" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should open" do
        expect{@rice_cooker.open_close}.to output(/Rice cooker is now open/).to_stdout
    end
    it "should be plugged out" do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        expect{@rice_cooker.open_close}.to output(/Rice cooker is now closed/).to_stdout
    end
    it "should raise ITISCOOKING error" do
        @rice_cooker.instance_variable_set(:@timer,5)
        expect{@rice_cooker.open_close}.to output("Error: The timer is on, you cant open the lid\n").to_stdout
    end
end

describe "Testing keep warm mode" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should be on" do
        expect{@rice_cooker.keep_warm_mode}.to output(/Keep Warm Mode is now On/).to_stdout
    end
    it "should be off" do
        @rice_cooker.instance_variable_set(:@keep_warm_mode,true)
        expect{@rice_cooker.keep_warm_mode}.to output(/Keep Warm Mode is now Off/).to_stdout
    end
end

describe "Check light status" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should be off" do
        expect{@rice_cooker.check_status_light}.to output(/Rice cooker is off/).to_stdout
    end
    it "should be heating" do
        @rice_cooker.instance_variable_set(:@is_heating,true)
        expect{@rice_cooker.check_status_light}.to output(/Rice Cooker is heating now\n/).to_stdout
    end
    it "should be under pressure" do
        @rice_cooker.instance_variable_set(:@is_under_pressure,true)
        expect{@rice_cooker.check_status_light}.to output(/Rice Cooker is under pressure now\n/).to_stdout
    end
    it "should be warming" do
        @rice_cooker.instance_variable_set(:@is_warm,true)
        expect{@rice_cooker.check_status_light}.to output(/Rice Cooker is now warm\n/).to_stdout
    end
end

describe "Add rice in the storage" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.put_rice_in_storage}.to output(/Error: The lid is still closed/).to_stdout
    end
    it 'should add rice to the storage' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("5\n")
        expect { @rice_cooker.put_rice_in_storage }.to output("Enter the amount of rice to put in the storage (kg): 5.0 kg of rice is now in the storage.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_rice)).to eq(5)
    end
    it 'should raise ToomuchRice' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("11\n")
        expect { @rice_cooker.put_rice_in_storage }.to output("Enter the amount of rice to put in the storage (kg): Error: You added too much rice\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_rice)).to eq(0)
    end
end

describe "Remove rice in the storage" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.remove_rice_from_storage}.to output(/Error: The lid is still closed/).to_stdout
    end
    it 'should remove rice to the storage' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@storage_rice,5)
        allow(@rice_cooker).to receive(:gets).and_return("4\n")
        expect { @rice_cooker.remove_rice_from_storage }.to output("Enter the amount of rice to remove from the storage (kg): 4.0 kg of rice is removed from the storage.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_rice)).to eq(1)
    end
    it 'should raise NoMoreRice' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@storage_rice,5)
        allow(@rice_cooker).to receive(:gets).and_return("11\n")
        expect { @rice_cooker.remove_rice_from_storage }.to output("Enter the amount of rice to remove from the storage (kg): Error: Not enough rice in the storage\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_rice)).to eq(5)
    end
end

describe "Add water in the storage" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.put_water_in_storage}.to output(/Error: The lid is still closed/).to_stdout
    end
    it 'should add water to the storage' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("5\n")
        expect { @rice_cooker.put_water_in_storage }.to output("Enter the amount of water to put in the storage (L): 5.0 L of water is now in the storage.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_water)).to eq(5)
    end
    it 'should raise ToomuchRice' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("11\n")
        expect { @rice_cooker.put_water_in_storage }.to output("Enter the amount of water to put in the storage (L): Error: You added too much water\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_water)).to eq(0)
    end
end

describe "Remove water in the storage" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.remove_rice_from_storage}.to output(/Error: The lid is still closed/).to_stdout
    end
    it 'should remove water to the storage' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@storage_water,5)
        allow(@rice_cooker).to receive(:gets).and_return("4\n")
        expect { @rice_cooker.remove_water_from_storage }.to output("Enter the amount of water to remove from the storage (L): 4.0 L of water is removed from the storage.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_water)).to eq(1)
    end
    it 'should raise NoMoreWater' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@storage_water,5)
        allow(@rice_cooker).to receive(:gets).and_return("11\n")
        expect { @rice_cooker.remove_water_from_storage }.to output("Enter the amount of water to remove from the storage (L): Error: Not enough water in the storage\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@storage_water)).to eq(5)
    end
end

describe "Check inside storage" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.check_inside}.to output(/Error: The lid is still closed/).to_stdout
    end
    it "should be show everything inside" do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        expect{@rice_cooker.check_inside}.to output("Inside the rice cooker: \nRice in Storage: 0 kg\nWater in Storage: 0 L\nIngredients in Steaming Basket: \n").to_stdout
    end
end

describe "Add ingredients in the basket" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.put_ingredients_in_basket}.to output(/Error: The lid is still closed/).to_stdout
    end
    it 'should add ingredient to the basket' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("carrot\n")
        expect { @rice_cooker.put_ingredients_in_basket }.to output("Enter the ingredient to put in the steaming basket: carrot is now in the steaming basket.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@ingredients_basket)).to eq(['carrot'])
      end
  
      it 'should raises NoMoreSpace' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@ingredients_basket, ['tomato', 'salad', 'carrot', 'onion'])
        allow(@rice_cooker).to receive(:gets).and_return("new\n")
        expect { @rice_cooker.put_ingredients_in_basket }.to output("Enter the ingredient to put in the steaming basket: Error: Basket is full\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@ingredients_basket)).to eq(['tomato', 'salad', 'carrot', 'onion'])
      end
end

describe "Remove ingredients in the basket" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.remove_ingredients_from_basket}.to output(/Error: The lid is still closed/).to_stdout
    end
    it 'should remove ingredient to the basket' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@ingredients_basket, ['tomato', 'salad', 'carrot', 'onion'])
        allow(@rice_cooker).to receive(:gets).and_return("carrot")
        expect { @rice_cooker.remove_ingredients_from_basket }.to output("Enter the ingredient to remove from the steaming basket: carrot is removed from the steaming basket.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@ingredients_basket)).to eq(['tomato', 'salad', 'onion'])
      end
  
      it 'should raises MissingIngredients' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@ingredients_basket, ['rato'])
        allow(@rice_cooker).to receive(:gets).and_return("carrot")
        expect { @rice_cooker.remove_ingredients_from_basket }.to output("Enter the ingredient to remove from the steaming basket: Error: Ingredient does not exist in the basket\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@ingredients_basket)).to eq(['rato'])
      end

      it 'should raises EmptyBasket' do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("carrot")
        expect { @rice_cooker.remove_ingredients_from_basket }.to output("Enter the ingredient to remove from the steaming basket: Error: The basket is empty\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@ingredients_basket)).to eq([])
      end
end

describe "Check inside basket" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should throw LidIsClosed message" do
        expect{@rice_cooker.check_inside_basket}.to output(/Error: The lid is still closed/).to_stdout
    end
    it "should be show everything inside (empty)" do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        expect{@rice_cooker.check_inside_basket}.to output("Inside the steaming basket: \nIngredients: []\n").to_stdout
    end
    it "should be show everything inside" do
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        @rice_cooker.instance_variable_set(:@ingredients_basket, ['rato'])
        expect{@rice_cooker.check_inside_basket}.to output("Inside the steaming basket: \nIngredients: [\"rato\"]\n").to_stdout
    end
end

describe "Set timer" do
    before(:each) do
        @rice_cooker = Main::RiceCooker.new
    end
    it "should check inside" do
        expect{@rice_cooker.set_timer}.to output(/There is nothing inside/).to_stdout
    end
    it "should check the power" do
        @rice_cooker.instance_variable_set(:@storage_rice,5)
        expect{@rice_cooker.set_timer}.to output("Error: Rice cooker is not plugged in\n").to_stdout
    end
    it "should check the lid" do
        @rice_cooker.instance_variable_set(:@storage_rice,5)
        @rice_cooker.instance_variable_set(:@power_on,true)
        expect{@rice_cooker.set_timer}.to output("Error: The lid is still open\n").to_stdout
    end
    it "should check the water" do
        @rice_cooker.instance_variable_set(:@storage_rice,5)
        @rice_cooker.instance_variable_set(:@power_on,true)
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        expect{@rice_cooker.set_timer}.to output("Error: Not enough water in the storage\n").to_stdout
    end
    it "should set the time" do
        @rice_cooker.instance_variable_set(:@storage_rice,5)
        @rice_cooker.instance_variable_set(:@storage_water,5)
        @rice_cooker.instance_variable_set(:@power_on,true)
        @rice_cooker.instance_variable_set(:@lid_closed,false)
        allow(@rice_cooker).to receive(:gets).and_return("5\n")
        expect{@rice_cooker.set_timer}.to output("Enter the timer value (minutes): Timer is set to 5 minutes.\n").to_stdout
        expect(@rice_cooker.instance_variable_get(:@lid_closed)).to eq(true)
    end
    describe "Exit the app" do
        before(:each) do
            @rice_cooker = Main::RiceCooker.new
        end
        it "should exit the app" do
            expect{@rice_cooker.exit_program}.to output(/Exiting the rice cooker program. Goodbye!/).to_stdout
        end
    end
end


