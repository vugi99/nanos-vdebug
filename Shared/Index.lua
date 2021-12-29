
Package.Require("Config.lua")

local Event_Types = {
    "Client_Events",
    "Shared_Events",
    "Server_Events"
}

for k, v in pairs(VDEBUG_CLASSES) do
    if v.Bases_Classes then
        for i2, v2 in ipairs(v.Bases_Classes) do
            local Base_class = Base_Classes[v2]
            if Base_class.Get_Funcs then
                if not VDEBUG_CLASSES[k].Get_Funcs then
                    VDEBUG_CLASSES[k].Get_Funcs = {}
                end
                for i3, v3 in ipairs(Base_class.Get_Funcs) do
                    table.insert(VDEBUG_CLASSES[k].Get_Funcs, v3)
                end
                --print(k, NanosUtils.Dump(VDEBUG_CLASSES[k].Get_Funcs))
            end
            for k3, v3 in pairs(Event_Types) do
                if Base_class[v3] then
                    if not VDEBUG_CLASSES[k][v3] then
                        VDEBUG_CLASSES[k][v3] = {}
                    end
                    for i4, v4 in ipairs(Base_class[v3]) do
                        table.insert(VDEBUG_CLASSES[k][v3], v4)
                    end
                end
            end
        end
    end
end

function GenerateDebugEvents(key)
    for k, v in pairs(VDEBUG_CLASSES) do
        if v[key] then
            for k2, v2 in ipairs(v[key]) do
                _ENV[k].Subscribe(v2, function(...)
                    local str_to_print = ""
                    for i3, v3 in ipairs({...}) do
                        if i3 == 1 then
                            str_to_print = str_to_print .. " : " .. tostring(v3)
                        else
                            str_to_print = str_to_print .. ", " .. tostring(v3)
                        end
                    end
                    Package.Log("vdebug : Class[" .. k .. "], Event[" .. v2  .. "]" .. str_to_print)
                end)
            end
        end
    end
end

if DEBUG_SHARED_EVENTS then
    GenerateDebugEvents("Shared_Events")
end