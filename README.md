# Defold Fixed Center Render v0.2


## Description

This is a render for the Defold game engine including support functions. It supports different screen aspect ratios where the default is 32:21. If it’s wider up to 16:9 (HD) or narrower down to 4:3 (iPad) the edges will be clipped. If the aspect ratio is bigger or smaller a black bar is shown at the sides.

## Install

In _game.project_ under Dependencies copy and page this path:

```text
https://github.com/stelmlu/defold-fixed-camera/archive/refs/tags/v0.2.zip
```

and then from Defold editor select the meny Project -> Fetch Libraries.

In your collection proxy (main.collection) add game object file (.go) fixed_camera/fixed_camera.go.

The default logical size for the 32:21 acpect ratio is 1024x672. You can change it by edit the following properties at the fixed_camera.go -> fixed_camera.script.

change the default values of the logical size and aspect ratio.

If yout want Portrait, like the size 672x1024 then Min Aspect Ratio become: 9, 16, 0 and Max Aspect Ratio becomes 3, 4, 0.

## Functions

To use feature from the Fixed Center you need to require the fixed_center module:

```lua
local fixed_center = require("render.fixed_center")
```

### fixed_center.get_viewport_rect()

Return the coordinates for the screen edges in world space. This can be negative if the side bars are shown.

```lua
local left, top, right, bottom = fixed_center.get_viewport_rect()
```

### fixed_center.screen_to_world(x, y)

Transform a position from the window space to world space. This can be used to translate mouse position to a world position.

local x, y = fixed_center.screen_to_world(message.x, message.y)


### fixed_center.world_to_screen(x, y)

Transform a position from world space to gui space.

```lua
local left, bottom = fixed_center.world_to_screen(message.bar.width, message.bar.height)
```

## Window Update Listener

You can listen if the window has changed size. The message will have the following structure:

### window_update

_Fields_

*   window (table) 
    *   width: screen width
    *   height: screen height
*   viewport (table)
    *   left: x coordinate for the left edge in world space
    *   top: y coordinate for the top edge in world space
    *   right: x coordinate for the right edge in world space
    *   bottom: y coordinate for the bottom edge in world space

### fixed_center.add_window_listener(url)

Register a url to be sent a message when the window is updated.

```lua
function init(self)
    self.url = msg.url()
    fixed_center.add_window_listener(self.url)
end
```

### fixed_center.remove_window_listener(url)

Remove a url to be sent a message when the window is updated. Make sure to remove the listener before the object is destroyed.

```lua
function final(self)
    fixed_center.remove_window_listener(self.url)
end
```
