local Level = {
	Error = 0,
	Warning = 1,
	Info = 2,
	Debug = 3,
	Trace = 4,
}

local function getLogLevel()
	return Level.Info
end

local function addTags(tag, message)
	return tag .. message:gsub("\n", "\n" .. tag)
end

local TRACE_TAG = (" "):rep(15) .. "[Rojo-Trace] "
local INFO_TAG = (" "):rep(15) .. "[Rojo-Info] "
local DEBUG_TAG = (" "):rep(15) .. "[Rojo-Debug] "
local WARN_TAG = "[Rojo-Warn] "

local Log = {}

Log.Level = Level

function Log.setLogLevelThunk(thunk)
	getLogLevel = thunk
end

function Log.trace(template, ...)
	if getLogLevel() >= Level.Trace then
		print(addTags(TRACE_TAG, string.format(template, ...)))
	end
end

function Log.info(template, ...)
	if getLogLevel() >= Level.Info then
		print(addTags(INFO_TAG, string.format(template, ...)))
	end
end

function Log.debug(template, ...)
	if getLogLevel() >= Level.Debug then
		print(addTags(DEBUG_TAG, string.format(template, ...)))
	end
end

function Log.warn(template, ...)
	if getLogLevel() >= Level.Warning then
		warn(addTags(WARN_TAG, string.format(template, ...)))
	end
end

return Log