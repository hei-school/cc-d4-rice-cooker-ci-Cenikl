local luaunit = require("luaunit")
dofile("rice_cooker.lua")

TestAddRice = {}
TestRemoveRice = {}
TestAddWater = {}
TestRemoveWater = {}


function TestAddRice:testValidAmount()
    AddRice(5)
    luaunit.assertEquals(RICE_STORAGE,5);
end

function TestAddRice:testExceedingLimit()
    local success, result = pcall(function()
        AddRice(11)
    end)
    luaunit.assertError("You are adding too much rice", result)
end

function TestRemoveRice:testValidAmount()
    AddRice(5)
    RemoveRice(4)
    luaunit.assertEquals(RICE_STORAGE,1);
end

function TestRemoveRice:testMinimumLimit()
    RemoveRice(5)
    local success, result = pcall(function()
        RemoveRice(1)
    end)
    luaunit.assertError("There is no rice", result)
end

function TestRemoveRice:testExceedingLimit()
    local success, result = pcall(function()
        RemoveRice(11)
    end)
    luaunit.assertError("You are removing too much rice", result)
end

function TestAddWater:testValidAmount()
    AddWater(5)
    luaunit.assertEquals(WATER_STORAGE,5);
end

function TestAddWater:testExceedingLimit()
    local success, result = pcall(function()
        AddWater(11)
    end)
    luaunit.assertError("You are adding too much water", result)
end

function TestRemoveWater:testValidAmount()
    AddWater(5)
    RemoveWater(4)
    luaunit.assertEquals(WATER_STORAGE,1);
end

function TestRemoveWater:testExceedingLimit()
    local success, result = pcall(function()
        RemoveWater(11)
    end)
    luaunit.assertError("You are removing too much water", result)
end

function TestRemoveWater:testMinimumLimit()
    RemoveWater(5)
    local success, result = pcall(function()
        RemoveWater(1)
    end)
    luaunit.assertError("There is no water", result)
end

os.exit(luaunit.LuaUnit.run())