local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = require(ReplicatedStorage.Cache)

local instance1 = Cache.new(true)
local instance2 = Cache.new(true, "CustomIdentifier!")
local instance3 = Cache.new(true)

--[[
    Get all instances created and then delete them to get their result back after deletion
    ```lua
    print(Cache.GetInstances()) --> {...}
    Cache.DestroyAll()
    print(Cache.GetInstances()) --> {}
    ```
]]
