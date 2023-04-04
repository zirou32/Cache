local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = require(ReplicatedStorage.Cache)

local imagesCache = Cache.new(false)
local insert = imagesCache:Insert("Somekey", "Somedata")
print(insert)
