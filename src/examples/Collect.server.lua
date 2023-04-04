local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = require(ReplicatedStorage.Cache)

local PublicInstance = Cache.GetPublic("CustomIdentifier!")
PublicInstance:Insert("Data", { 1, 2, 3, 4 })
local publicData = PublicInstance:Collect("Data")
print(publicData)

local LocalInstance = Cache.new(false)
LocalInstance:Insert("Data", { 4, 3, 2, 1 })
local data = LocalInstance:Collect("Data")
print(data)
