--[[
MIT License

Copyright (c) 2023 Galaxy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local HttpService = game:GetService("HttpService")

-- Modules
local Symbol = require(script.Symbol)
-- local TableUtil = require(script.TableUtil)
local Settings = require(script.Settings)

-- Types
type CacheSettings = {
	Yields: boolean, --TODO
	Debug: boolean, --TODO
}

-- Cache instances
local CacheInstances = {}
local __Private = {}

local function WaitForInstance(identifier: any)
	local attempts = 0
	repeat
		attempts += 1
		task.wait(Settings.DelayBetweenAttempts)
	until CacheInstances[identifier] or attempts >= Settings.MaxAttempts
end

-- Cache object
local Cache = {}
Cache.__index = Cache

--[[
	creates a new instance
]]
function Cache.new(public: boolean, identifier: any, _settings: CacheSettings?)
	local self = setmetatable({}, Cache)
	self._ID = identifier or Symbol(HttpService:GenerateGUID(false))
	self._CACHE = {}
	self._CONFIG = _settings

	if public then
		CacheInstances[self._ID] = self
	else
		__Private[self._ID] = self
	end
	return self
end

--[[
	returns an instance of another script as long as it is public, and in case it does not exist, it will throw an error
	@param identifier	any		the instance identifier (it is recommended to use it as long as the instance has a custom identifier)	
]]
function Cache.GetPublic(identifier: any)
	WaitForInstance(identifier)
	if not CacheInstances[identifier] then
		error(`{identifier} doesn't exists`, 2)
	end
	return CacheInstances[identifier]
end

--[[
	Adds a new value to the CACHE table of the current instance
	@param key		any		key with which it can be accessed in the future.
	@param data		any		information to add
]]
function Cache:Insert(key: any, data: any): any
	if self._CACHE[key] == data then
		return self._CACHE[key]
	end
	self._CACHE[key] = data
	return data
end

--[[
	Gets the value passed as an argument stored in cache, and in case it does not exist returns 'none'.

	@param key		any | nil		The key with which the value to be obtained was saved

	@returns the data to be obtained
]]
function Cache:Collect(key: any | nil): any
	if key == nil then
		return self._CACHE
	end
	return self._CACHE[key] or "none"
end

--[[
	The key with which the value to be obtained was saved

	@returns all instances currently created
]]
function Cache.GetInstances(): { any }
	return CacheInstances
end

--[[
	Destroys the instance rendering it unusable
]]
function Cache:Destroy()
	table.clear(self)
end

--[[
	destroys ALL instances including those of other scripts

	!WARNING: do not do this unless you have already stopped using your instances, as it will render all created instances unusable
]]
function Cache.DestroyAll()
	table.clear(CacheInstances)
	table.clear(__Private)
end

return Cache
