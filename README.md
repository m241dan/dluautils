# dluautils
Just a nifty little lua utils module for 5.3

Written by Daniel R. Koris

This library requires [lfs](https://github.com/keplerproject/luafilesystem)

This library does a few simple things:
* __table.getn( table ):__ get the real size of the table
* __table.getKey( table, value ):__ returns the key for a given value if it is in the table
* __table.contains( table, value ):__ returns true if the table contains the given value
* __string.capitalize( string ):__ returns a capitalized version of a string
* __string.split( string, delimiter):__ returns a table of strings at the delimiter (defaults to spaces)
* __requireCheck( rpath ):__ returns true if a file is there and can be required (automatically adds ".lua" extension)
* __save( data, file ):__ serializes data to given file(custom tables will need specialized :serialize() functions)
* __fileExists( path ):__ check to see if a file exists
