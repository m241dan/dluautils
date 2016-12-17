local LFS = require( "lfs" )

local utils = {}

function utils.fileExists( path )
   local f = io.open( path, "r" )
   if( not f ) then
      return false
   end
   f:close()
   return true
end;

function utils.requireCheck( rpath )
   if( not rpath ) then
      error( "requireCheck failed: nil path", 1 )
      return false
   end
   rpath = rpath .. ".lua"
   if( not LFS.attributes( rpath ) ) then
      error( "requireCheck failed: path is not a file", 1 )
      return false
   end
   return true
end

function table.getn( table )
   local count = 0
   for _, _ in pairs( table ) do count = count + 1; end
   return count
end

function table.getKey( table, value )
   for key, val in pairs( table ) do
      if( value == val ) then
         return key
      end
   end
   return nil
end

function table.contains( table, value )
   for key, val in pairs( table ) do
      if( val == value ) then
         return true
      end
   end
   return false
end

function string.capitalize( string )
   string = string:lower()
   string = string:gsub( "(%l)(%w*)", function( a,b ) return a:upper() .. b; end )
   return string
end;

-- stole basic logic from: http://lua-users.org/wiki/SplitJoin
function string.split( str, delimiter )
   local delimiter, fields = delimiter or " ", {}
   local pattern = string.format( "[^%s]+)", delimiter )
   str:gsub( pattern, function( c ) fields[#fields+1] = c; end )
   return fields
end

local function serialize( data, indent_amount )
   if( type( data ) == "string" ) then
      return string.format( "%q", data ) 
   elseif( type( data ) == "number" ) then
      return tostring( data )
   else
      if( not data.serialize or data.serialize == "table" ) then
         local tab_str, str = { "{" }, nil
         indent_amount = indent_amount + 3
         for k, v in pairs( data ) do
            str = string.format( "%s[%s] = %s,", string.rep( " ", indent_amount ), serialize( k, indent_amount ), serialize( v, indent_amount ) )
            tab_str[#tab_str+1] = str
         end
         tab_str[#tab_str+1] = string.format( "%s}", string.rep( " ", indent_amount - 3 ) )
         return table.concat( tab_str, "\n" )
      else
         return data:serialize()
      end
   end
end

function utils.save( data, file )
   local phs = data.serialize -- place holder serialize function
   file:write( "return " )
   data.serialize = "table"
   file:write( serialize( data, 0 ) )
   data.serialize = phs
end

return utils

