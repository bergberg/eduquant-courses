function Header(el)
    if el.level == 1 then
      table.insert(el.classes, "inverse")
      el.attributes["data-background-color"] = "teal"
      return el
    end
end
