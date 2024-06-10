local yabai = require "yabai.yabai_cmd"

function getSpacesThen(cb)
  function decodeAndCb(data)
    local spaces = hs.json.decode(data)
    cb(spaces)
  end

  yabai({ "-m", "query", "--spaces" }, function(spacesData)
    --Added simple retry logic to fix passing of an empty string in error.
    if #spacesData == 0 then
      hs.timer.doAfter(0.01, function()
        yabai({ "-m", "query", "--spaces" }, function(spacesData)
          decodeAndCb(spacesData)
        end)
      end):start()
    else
      decodeAndCb(spacesData)
    end
  end)
end

function findSpaceThen(idxOrLabel, cb)
  getSpacesThen(function(spaces)
    local space = nil
    for _, s in ipairs(spaces) do
      if s.index == idxOrLabel or tostring(s.index) == idxOrLabel or s.label == idxOrLabel then
        space = s
        break
      end
    end
    if space then
      cb(space)
    end
  end)
end

local spaces = {
  new = function()
    hs.spaces.addSpaceToScreen()
  end,
  focus = function(idxOrLabel)
    findSpaceThen(idxOrLabel, function(space)
      hs.spaces.gotoSpace(space.id)
      if #(space.windows) >= 1 then
        local window = hs.window.find(space.windows[1])
        if window then
          window:focus()
        end
      end
    end)
  end,
  remove = function(idxOrLabel)
    if idxOrLabel then
      findSpaceThen(idxOrLabel, function(space)
        print(space)
        hs.spaces.removeSpace(space.id)
      end)
    end
  end,
  removeEmpty = function()
    getSpacesThen(function(spaces)
      for _, s in ipairs(spaces) do
        if #(s.windows) == 0 then
          hs.spaces.removeSpace(s.id)
        end
      end
    end)
  end,
  moveWindow = function(idxOrLabel)
    findSpaceThen(idxOrLabel, function(space)
      local window = hs.window.focusedWindow()
      if window then
        hs.spaces.moveWindowToSpace(window:id(), space.id)
        hs.spaces.gotoSpace(space.id)
      end
    end)
  end,
}

yabaiipc = {
  spaces = spaces
}
