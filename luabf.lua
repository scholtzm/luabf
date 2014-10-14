--------------------------------------------------------
-- Brainfuck interpreter written in Lua
-- Author: Michael Scholtz <michael.scholtz@outlook.com>
-- Licence: MIT
--------------------------------------------------------

return function(s)
    local bf, d, p, sp = "[^><%+%-%.,%[%]]+", {}, 1, 0
    s = s:gsub(bf, "")

    while sp <= #s do
        local c = s:sub(sp,sp)

        if c == ">" then
            p = p + 1
        elseif c == "<" then
            p = p - 1
        elseif c == "+" then
            if d[p] then d[p] = d[p] + 1 else d[p] = 1 end
        elseif c == "-" then
            if d[p] then d[p] = d[p] - 1 else d[p] = -1 end
        elseif c == "." then
            io.write(string.char(d[p]))
        elseif c == "," then
            local _c = io.read(1)
            if _c ~= nil then d[p] = _c:byte() end
        elseif c == "[" then
            if d[p] == 0 or d[p] == nil then
                local i = 1
                while i ~= 0 do
                    sp = sp + 1
                    local _c = s:sub(sp, sp)
                    if _c == "[" then i = i + 1 elseif _c == "]" then i = i - 1 end
                end
            end
        elseif c == "]" then
            if d[p] ~= 0 and d[p] ~= nil then
                local i = 1
                while i ~= 0 do
                    sp = sp - 1
                    local _c = s:sub(sp, sp)
                    if _c == "]" then i = i + 1 elseif _c == "[" then i = i - 1 end
                end
            end
        end

        sp = sp + 1
    end
end
