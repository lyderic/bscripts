--
-- lua module contains Functions, custom names and constants
-- used by Lyderic
-- This is only intended to work on a Posix system (sorry Windows)

-- these function must be in a file called 'lyderic.lua', in a lua
-- library path (e.g. /usr/local/share/lua/<version>)
-- and be import to a lua script as e.g.: local lee = require lyderic

sf = string.format
ose = os.execute

local function home()
  return os.getenv("HOME")
end

local function dumptable(t)
  if not t then return end
  if not type(t) == "table" then return end
  for k,v in pairs(t) do print(k,v) end
end

local function exists(path)
	return ose(sf("test -e %q", path))
end

local function mkdir(dir)
	return ose(sf("mkdir %q", dir))
end

local function rmdir(dir)
	return ose(sf("rmdir %q", dir))
end

local function ls(dir)
	if dir == nil then dir = "." end
	ose(sf("ls %q", dir))
end

local function absolutepath(file)
	local command = sf("readlink -f %q", file)
	return io.popen(command):read()
end

local function listing(dir)
	if dir == nil then dir = "." end
	local command = sf("ls %q", dir)
	out = io.popen(command):lines()
	local t = {}
	for item in out do
		table.insert(t, item)
	end
	return t
end

local function red(s)
	io.write("\27[1;31m"..s.."\27[0m")
end

local function green(s)
	io.write("\27[1;32m"..s.."\27[0m")
end

local function yellow(s)
	io.write("\27[1;33m"..s.."\27[0m")
end

return {
	home = home,
	dumptable = dumptable,
	exists = exists,
	mkdir = mkdir,
	rmdir = rmdir,
	ls = ls,
	absolutepath = absolutepath,
	listing = listing,
	red = red,
	green = green,
	yellow = yellow,
}
