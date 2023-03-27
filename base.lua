---@diagnostic disable-next-line: lowercase-global
function class(base, parent_class)
    --[[
        Syntax 1:
            local ClassWithoutInherits = class {
                -- class definition
            }

        Syntax 2:
            local InheritedClass = class (AnotherClass) {

            }
    ]]
    local new_class = {}

    if base.__type == "class" then
        setmetatable(new_class, { __index = base })
        new_class.__base = base

        return function(inner_arg)
            return class(inner_arg, base)
        end
    end

    new_class = base
    new_class.__class = new_class
    new_class.__type = "class"
    new_class.__super = parent_class

    local class_meta = {
        __call = function(cls, ...)
            local obj = setmetatable({}, { __index = cls})
            if cls.__init then
                cls.__init(obj, ...)
            end
            return obj
        end,
        __index = parent_class
    }
    setmetatable(new_class, class_meta)
    return new_class
end