local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cache = require(ReplicatedStorage.Cache)

--[[
Get a table with all its data from another script (client or server)

```lua
local CustomIdentifier = Cache.GetPublic("CustomIdentifier!") --- Ok
--local CustomIdentifier = Cache.GetPublic("CustomIdentifier!!!!!") --- Not ok (throws an error because there is no instance with that identifier)
CustomIdentifier:SomeMethod()
```
]]
