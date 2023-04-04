local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = require(ReplicatedStorage.Cache)

task.wait(2)

local a = Cache.new(false)
a:Insert("a", "b")

print(Cache.GetInstances())
Cache.DestroyAll()
print(Cache.GetInstances())

print(Cache.GetPublic("CustomIdentifier!"):Collect("Data"))
