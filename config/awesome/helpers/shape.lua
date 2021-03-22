local gears = require("gears")

shape = {}

-- Create rounded rectangle shape (in one line)

function shape.rrect(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

-- Create partially rounded rect

function shape.prrect(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl,
                                           radius)
    end
end

-- what shape?
function shape.custom_shape(cr, width, height)
    cr:move_to(0, height / 25)
    cr:line_to(height / 25, 0)
    cr:line_to(width, 0)
    cr:line_to(width, height - height / 25)
    cr:line_to(width - height / 25, height)
    cr:line_to(0, height)
    cr:close_path()
end

return shape
