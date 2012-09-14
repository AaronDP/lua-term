Overview
--------

lua-term is a Lua module for manipulating a terminal.

Installation
------------

lua-term is available on Luarocks.

Usage
-----

```lua
    local term   = require 'term'
    local colors = term.colors -- or require 'term.colors'

    print(term.isatty(io.stdout)) -- true if standard output goes to the terminal

    print(color.red 'hello')
    print(color.red .. 'hello' .. color.reset)
    print(color.red, 'hello', color.reset)

    -- The following functions take an optional IO handle (like io.stdout);
    -- io.stdout is the default if you don't specify one
    term.clear()    -- clears the screen
    term.cleareol() -- clears from the cursor to the end of the line
    term.cursor.goto(1, 1)
    term.cursor.goto(io.stdout, 1, 1)
    term.cursor.goup(1)
    term.cursor.godown(1)
    term.cursor.goright(1)
    term.cursor.goleft(1)
    term.cursor.save()    -- save position
    term.cursor.restore() -- restore position
```
