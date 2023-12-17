local RICE_STORAGE = 0
local WATER_STORAGE = 0
local ingredients_basket = {}
local TIMER = 0
local keep_warm_mode = false
local power_on = false
local lid_closed = true
local is_heating = false
local is_under_pressure = false
local is_warm = false

function DisplayOptions()
    print("Options:")
    print("1 - Plug In/Plug Out")
    print("2 - Open/Close")
    print("3 - Keep warm mode ")
    print("4 - Check status light")
    print("5 - Put ingredients in the main storage")
    print("6 - Put ingredients in the steaming basket")
    print("7 - Set the TIMER")
    print("8 - Stop the TIMER")
    print("9 - Exit")
end

function MainMenu()
    DisplayOptions()
    local choice = io.read("*n")

    local success,result = pcall(function()
        if choice == 1 then
            power_on = not power_on
            print("Rice cooker is now " .. (power_on and "plugged in" or "plugged out"))
            MainMenu()
        elseif choice == 2 then
            lid_closed = not lid_closed
            print("Rice cooker is now " .. (lid_closed and "closed" or "open"))
            MainMenu()
        elseif choice == 3 then
            keep_warm_mode = not keep_warm_mode
            print("Keep warm mode is now " .. (keep_warm_mode and "on" or "off"))
            MainMenu()
        elseif choice == 4 then
            if is_heating == true then
                print("Rice cooker is heating")
            elseif is_under_pressure == true then
                print("Rice cooker is under pressure")
            elseif is_warm == true then
                print("Rice cooker is warming up")
            else
                print("Rice cooker is not plugged in")
            end
            print("Status light is " .. (power_on and "on" or "off"))
            MainMenu()
        elseif choice == 5 then
            MainStorageMenu()
        elseif choice == 6 then
            SteamingBasketMenu()
        elseif choice == 7 then
            SetTIMER()
            MainMenu()
        elseif choice == 8 then
            StopTIMER()
            MainMenu()
        elseif choice == 9 then
            print("Exiting the rice cooker.")
        else
            error("Invalid choice. Please try again.")
            MainMenu()
        end
    end)
    if not success then
        print("Error:",result)
        MainMenu()
    end
end

function MainStorageMenu()
    print("Main Storage Options:")
    print("1 - Put rice (max 10 kg)")
    print("2 - Remove rice")
    print("3 - Put water (max 10 L)")
    print("4 - Remove water")
    print("5 - Check inside")
    print("6 - Exit")

    local choice = io.read("*n")

    local success,result = pcall(function()
        if choice == 1 then
            print("Enter the amount of rice to put (max 10 kg):")
            local amount = io.read("*n")
            AddRice(amount)
            MainStorageMenu()
        elseif choice == 2 then
            print("Enter the amount of rice to remove:")
            local amount = io.read("*n")
            RemoveRice(amount)
            MainStorageMenu()
        elseif choice == 3 then
            print("Enter the amount of water to put (max 10 L):")
            local amount = io.read("*n")
            AddWater(amount)
            MainStorageMenu()
        elseif choice == 4 then
            print("Enter the amount of water to remove:")
            local amount = io.read("*n")
            RemoveWater(amount)
            MainStorageMenu()
        elseif choice == 5 then
            print("Checking inside the main storage...")
            print("Current amount of rice: " .. RICE_STORAGE .. " kg")
            print("Current amount of water: " .. WATER_STORAGE .. " L")
            MainStorageMenu()
        elseif choice == 6 then
            print("Exiting main storage menu.")
            MainMenu()
        else
            error("Invalid choice. Please try again.")
            MainStorageMenu()
        end
    end)
    if not success then
        print("Error:",result)
        MainStorageMenu()
    end
end

function AddRice(amount)
    local success,result = pcall(function ()
        if((RICE_STORAGE + amount) > 10) then
            error("You are adding too much rice")
        end
        RICE_STORAGE = RICE_STORAGE + amount
        print("Rice added to the storage. Current amount: " .. RICE_STORAGE .. " kg")
    end)
    if not success then
        print("Error:",result)
        MainStorageMenu()
    end
end
function RemoveRice(amount)
    local success,result = pcall(function ()
        if((RICE_STORAGE - amount) > 0) then
            error("You are adding too much rice")
        end
        if((RICE_STORAGE == 0)) then
            error("There is no rice")
        end
        RICE_STORAGE = RICE_STORAGE - amount
        print("Rice removed from the storage. Current amount: " .. RICE_STORAGE .. " kg")
    end)
    if not success then
        print("Error:",result)
        MainStorageMenu()
    end
end

function AddWater(amount)
    local success,result = pcall(function ()
        if((WATER_STORAGE + amount) > 10) then
            error("You are adding too much water")
        end
        WATER_STORAGE = WATER_STORAGE + amount
        print("Water added to the storage. Current amount: " .. WATER_STORAGE .. " L")
    end)
    if not success then
        print("Error:",result)
        MainStorageMenu()
    end
end
function RemoveWater(amount)
    local success,result = pcall(function ()
        if((WATER_STORAGE - amount) > 0) then
            error("You are adding too much water")
        end
        if((WATER_STORAGE == 0)) then
            error("There is no water")
        end
        WATER_STORAGE = WATER_STORAGE - amount
        print("Water removed from the storage. Current amount: " .. WATER_STORAGE .. " L")
    end)
    if not success then
        print("Error:",result)
        MainStorageMenu()
    end
end

function SteamingBasketMenu()
    print("Steaming Basket Options:")
    print("1 - Put ingredients in it")
    print("2 - Remove ingredients")
    print("3 - Check inside")
    print("4 - Exit")

    local choice = io.read("*n")
    local success,result = pcall(function()
        if choice == 1 then
            AddIngredientToBasket()
            SteamingBasketMenu()
        elseif choice == 2 then
            RemoveIngredientFromBasket()
            SteamingBasketMenu()
        elseif choice == 3 then
            print("Checking inside the steaming basket...")
            print("Currently contains ingredients:")
            for _, ingredient in ipairs(ingredients_basket) do
                print("-", ingredient)
            end
            SteamingBasketMenu()
        elseif choice == 4 then
            print("Exiting steaming basket menu.")
            MainMenu()
        else
            error("Invalid choice. Please try again.")
            SteamingBasketMenu()
        end
    end)
    if not success then
        print("Error:",result)
        SteamingBasketMenu()
    end
end

function AddIngredientToBasket()
    local success, result = pcall(function()
        if #ingredients_basket > 10 then
            error("The basket is full")
        end
        print("Choose the type of ingredient to add:")
        print("1 - Vegetables")
        print("2 - Meat")
        print("3 - Others")

        local choice = io.read("*n")
        io.read()

        local ingredientType
        if choice == 1 then
            ingredientType = "Vegetables"
        elseif choice == 2 then
            ingredientType = "Meat"
        elseif choice == 3 then
            ingredientType = "Others"
        else
            error("Invalid choice. Ingredient not added.")
        end

        print("Enter the specific ingredient:")
        local specificIngredient = io.read()

        local fullIngredient = ingredientType .. ": " .. specificIngredient
        table.insert(ingredients_basket, fullIngredient)
        print("Ingredient added to the steaming basket.")
    end)

    if not success then
        print("Error:", result)
    end
end

function RemoveIngredientFromBasket()
    local success, result = pcall(function()
        if #ingredients_basket == 0 then
            error("The basket is empty")
        end
        print("Enter the ingredient to remove:")
        local ingredient = io.read("*l")

        if not ingredient then
            error("Invalid input. Ingredient not removed.")
        end

        ingredient = ingredient:match("^%s*(.-)%s*$")

        if IsIngredientInBasket(ingredient) then
            for i, value in ipairs(ingredients_basket) do
                if value == ingredient then
                    table.remove(ingredients_basket, i)
                    print("Ingredient removed from the steaming basket.")
                    return
                end
            end
        else
            error("Ingredient not found in the steaming basket.")
        end
    end)

    if not success then
        print("Error:", result)
    end
end

function IsIngredientInBasket(ingredient)
    for _, value in ipairs(ingredients_basket) do
        if value == ingredient then
            return true
        end
    end
    return false
end

function SetTIMER()
    local success, result = pcall(function()
        if power_on == false then
            error("Rice cooker is plugged out")
        elseif lid_closed == false then
            error("Rice cooker is open")
        elseif RICE_STORAGE > 0 or #ingredients_basket > 0 then
            if WATER_STORAGE == 0 then
                error("There is no water")
            end
            print("Enter the TIMER duration in minutes:")
            local duration = io.read("*n")
            TIMER = duration
            is_heating = false
            is_under_pressure = true
            for i = duration,0,-1
            do
                print(i)
            end
            print("Finished")
            is_under_pressure = false
            is_warm = true
        else
            error("The rice cooker is empty")
        end
    end)
    if not success then
        print("Error:", result)
    end
end

function StopTIMER()
    TIMER = 0
    print("You stopped the TIMER")
end

MainMenu()
