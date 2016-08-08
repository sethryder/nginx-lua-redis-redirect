-- config
local redis_server = ""
local redis_port = 6379
local redis_timeout = 1000 -- milliseconds

-- setup redis
local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(redis_timeout)

--connect to redis
local ok, err = red:connect(redis_server, redis_port)
if not ok then
  return -- don't error if it can't connect, just continue on
end

--check redis for uri to see if redirect exists
local key = ngx.var.uri
local res, err = red:get(key)

-- check if the key/redirect was found
if res ~= ngx.null then
  -- redirect exists, return redirect
  ngx.redirect(res, 301)
end
