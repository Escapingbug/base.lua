require "base"

local MyClass = class {
    -- class variable
    a = 2,

    -- constructor
    __init = function(self, arg1)
        -- object variable
        self.arg1 = arg1
        self.a = 1
        self.obj_var = 1
    end,

    -- method
    pp = function(self)
        print(string.format("arg1 is %s, a is %d", self.arg1, self.a))
        print(string.format("class a is %d", self.__class.a))

        assert(self.arg1 == "hello", "incorrect arg1")
        assert(self.a == 1, "incorrect a")
        assert(self.__class.a == 2, "incorrect class a")
    end
}

local obj = MyClass("hello")

for k, v in pairs(obj) do
    print(k, v)
end

-- property access
print(string.format("arg1 is %s, a is %s", obj.arg1, tostring(obj.a)))
assert(obj.arg1 == "hello", "incorrect arg1")
assert(obj.a == 1, "incorrect a")
assert(obj.__class.a == 2, "incorrect class a")

-- method
obj:pp()

local SubClass = class(MyClass) {
    a = 2,
    x = 3,

    __init = function(self)
        self.__super.__init(self, "hello")
    end
}

local my_sub = SubClass("hello")

my_sub:pp()
assert(my_sub.x == 3, "sub.x is not 3")
print(my_sub.a)
assert(my_sub.__class.a == 2, "sub.a is not 2")
assert(my_sub.obj_var == 1, "parent obj var not found")