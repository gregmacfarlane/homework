
homeworkcount = 0

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
