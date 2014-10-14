# luabf

[Brainfuck](http://en.wikipedia.org/wiki/Brainfuck) interpreter written in Lua.

## Usage

```lua
local bf = require("luabf")

-- prints "!"
bf("+++++[>++++++<-]>+++.")
```

This will obviously work too ...

```lua
require("luabf")("+++++[>++++++<-]>+++.")
```

See examples for more elaborate code samples.

## License

See `LICENSE`.
