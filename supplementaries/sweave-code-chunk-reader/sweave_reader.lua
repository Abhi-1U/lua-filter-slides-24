-- For better performance we put these functions in local variables:
local P, S, R, Cf, Cc, Ct, V, Cs, Cg, Cb, B, C, Cmt =
  lpeg.P, lpeg.S, lpeg.R, lpeg.Cf, lpeg.Cc, lpeg.Ct, lpeg.V,
  lpeg.Cs, lpeg.Cg, lpeg.Cb, lpeg.B, lpeg.C, lpeg.Cmt

local whitespacechar = S(" \t\r\n")
local wordchar = (1 - whitespacechar)
local spacechar = S(" \t")
local newline = P"\r"^-1 * P"\n"
local blankline = spacechar^0 * newline
local blanklines = newline * (spacechar^0 * newline)^1
local endline = newline - blanklines


-- Grammar
G = P{ "Pandoc",
  Pandoc = Ct(V"Block"^0) / pandoc.Pandoc;
  Block = blankline^0 * (V"CodeBlock" + V"Para") ;
  Para = P(P(1) - P"<<")^1* newline^0;
  CodeBlock = P"<<"
            * C((1- (newline * P'@'))^0)
            * newline
            * P'@'
            /pandoc.CodeBlock;
}

function Reader(input)
  return lpeg.match(G, tostring(input))
end
