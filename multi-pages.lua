-- Define the array of different pages/endpoints to target
local paths = {
   "/",
   "/products",
   "/search?q=organic",
   "/category/dairy"
}

counter = 1

request = function()
   -- Cycle through the paths array sequentially
   local path = paths[counter]
   counter = counter + 1
   if counter > #paths then
      counter = 1
   end
   return wrk.format(nil, path)
end

