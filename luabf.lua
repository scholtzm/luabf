--------------------------------------------------------
-- Brainfuck interpreter written in Lua
-- Author: Michael Scholtz <michael.scholtz@outlook.com>
-- Licence: MIT
--------------------------------------------------------

return function(code)
    -- Brainfuck language consists of 8 instructions "><+-.,[]", everything else can be removed
    local brainfuck = "[^><%+%-%.,%[%]]+"

    -- Data tape consists of "infinite" amount of cells
    local data = setmetatable({}, {__index = function() return 0 end})

    -- Data pointer begins at position 1
    local dataPointer = 1

    -- Instruction pointer begins at position 1
    local instructionPointer = 1

    -- Remove everything from the code except for the 8 instructions defined above
    code = code:gsub(brainfuck, "")

    -- Implementation of the 8 instructions starts below
    while instructionPointer <= #code do
        local instruction = code:sub(instructionPointer,instructionPointer)

        if instruction == ">" then
            dataPointer = dataPointer + 1
        elseif instruction == "<" then
            dataPointer = dataPointer - 1
        elseif instruction == "+" then
            data[dataPointer] = data[dataPointer] + 1
        elseif instruction == "-" then
            data[dataPointer] = data[dataPointer] - 1
        elseif instruction == "." then
            io.write(string.char(data[dataPointer]))
        elseif instruction == "," then
            local character = io.read(1)
            if character ~= nil then data[dataPointer] = character:byte() end
        elseif instruction == "[" then
            if data[dataPointer] == 0 then
                local i = 1
                while i ~= 0 do
                    instructionPointer = instructionPointer + 1
                    local _instruction = code:sub(instructionPointer, instructionPointer)
                    if _instruction == "[" then i = i + 1 elseif _instruction == "]" then i = i - 1 end
                end
            end
        elseif instruction == "]" then
            if data[dataPointer] ~= 0 then
                local i = 1
                while i ~= 0 do
                    instructionPointer = instructionPointer - 1
                    local _instruction = code:sub(instructionPointer, instructionPointer)
                    if _instruction == "]" then i = i + 1 elseif _instruction == "[" then i = i - 1 end
                end
            end
        end

        instructionPointer = instructionPointer + 1
    end
end
