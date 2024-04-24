-- A Pandoc Lua filter to read a file and include its contents as code in a code Block.

function file_exists(file)
  local f_obj = io.open(file, "rb")
  if f_obj then 
  	f_obj:close() 
  end
  return f_obj ~= nil
end

function read_lines(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end
--[[ 
Target : CodeBlocks with specific command \includecode{}  
]]
function CodeBlock(block)
	local code = pandoc.utils.stringify(block.text)
	if code:match("\\includecode{(.-)}") then
		s, e, file_name = string.find(code,"\\includecode{(.-)}")
		block.text = table.concat(read_lines(file_name),"\n")
	end
	return block
end
