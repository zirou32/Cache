local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = require(ReplicatedStorage.Cache)

local myCache = Cache.new(false, "some")
myCache:Insert("test", "data")
print(myCache:Remove("test")) -- nil
print(myCache:Collect("test")) -- nil
