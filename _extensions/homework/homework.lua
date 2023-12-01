
homeworkcount = 0


local options_solution = nil
-- permitted options include:
-- solution: true/false
local function read_meta(meta)
  local options = meta["show-solution"]
  if options ~= nil then
    options_solution = options
  end
end

function Header(el)
  -- Look to see if headers have a homework tag.
  if(el.classes[1] == "homework") then
    -- Create a table for classes if it doesn't exist
    -- Add the unnumbered class to the header
    table.insert(el.classes, "unnumbered")
    -- Increment counter
    homeworkcount = homeworkcount + 1
    -- append homework tag to front
    text = "HW ".. homeworkcount .. ": ".. pandoc.utils.stringify(el.content)
    return pandoc.Header(el.level, text, el.attr)
  else
    return el
  end
end


local function Div(el)
  local options_collapse = true
  if (el.classes:includes("cell") and el.attributes["homework-key"] == "true") or (el.classes:includes("homework-key")) then
    el.attributes["homework-key"] = nil
    -- Embed solution code/block inside a callout if global option is true
    if options_solution then
      if quarto.doc.hasBootstrap() or quarto.doc.isFormat("revealjs") then
        quarto.doc.addHtmlDependency({
          name = "homework",
          version = "1.0.0",
          stylesheets = { "homework.css" }
        })
      end
      -- collapse callout by default except specified
      if el.attributes["key-collapse"] == "false" then
        options_collapse = false
      else
        options_collapse = false
      end
      return { quarto.Callout({
        content = { el },
        icon = false,
        title = "Solution",
        collapse = options_collapse,
        type = "caution"
      }) }
    else
      return {} -- remove the solution chunks for questions
    end
  end
end



-- Run in two passes so we process metadata
-- and then process the divs
return {
  { Meta = read_meta },
  { Div = Div },
  { Header = Header}
}
