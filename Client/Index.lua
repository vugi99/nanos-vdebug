
local start_group_id = 57234

local Texts_On_Screen = {}
for k, v in pairs(VDEBUG_CLASSES) do
    if v.Get_Funcs then
        Texts_On_Screen[k] = {}
    end
end

function table_count(ta)
    local count = 0
    for k, v in pairs(ta) do
        count = count + 1
    end
    return count
end

function IsGoodDistance(entity)
    local good_distance = true
    local ply = Client.GetLocalPlayer()
    if ply then
        local from_loc
        local char = ply:GetControlledCharacter()
        if char then
            from_loc = char:GetLocation()
        else
            from_loc = ply:GetCameraLocation()
        end
        local dist_sq = from_loc:DistanceSquared(entity:GetLocation())
        if dist_sq > Show_Info_Max_Distance_sq then
            good_distance = false
        end
    end
    return good_distance
end

function NewTextOnScreen(entity, class_name, group_id, item_text)
    local project = Render.Project(entity:GetLocation())
    local good_distance = IsGoodDistance(entity)
    if (project.X ~= -1.0 and project.Y ~= -1.0 and good_distance) then
        local count = 0
        if Texts_On_Screen[class_name][entity:GetID()] then
            count = table_count(Texts_On_Screen[class_name][entity:GetID()].items)
        end
        local offset_calculate = math.floor((count - (count / 2)))
        local y_offset = Each_Text_Y_Offset * offset_calculate
        local item_pos = project + Vector2D(0, y_offset)
        local item_id = Render.AddText(
            group_id,
            item_text,
            item_pos,
            FontType.Roboto,
            Screen_Text_Font_Size,
            Color(1, 1, 1),
            0,
            true,
            true,
            false,
            Vector2D(0, 0),
            Color.BLACK,
            false,
            Color.BLACK
        )
        if count > 0 then
            for k, v in pairs(Texts_On_Screen[class_name][entity:GetID()].items) do
                Render.UpdateItemPosition(group_id, v.id, Vector2D(project.X, math.floor(((v.custom_id - 1) - (count / 2))) * Each_Text_Y_Offset))
            end
        end
        return item_id, count + 1
    end
end

function DrawGetFuncOnScreen(entity, class_name, func_name, returned)
    local item_text = func_name .. ": "
    for i, v in ipairs(returned) do
        if i == 1 then
            item_text = item_text .. tostring(v)
        else
            item_text = item_text .. ", " .. tostring(v)
        end
    end
    local Texts = Texts_On_Screen[class_name][entity:GetID()]
    if Texts then
        if Texts.items[func_name] then
            local group_id = Texts.group_id
            local item_id = Texts.items[func_name].id
            local good_distance = IsGoodDistance(entity)
            Render.UpdateItemText(group_id, item_id, item_text)
            local project = Render.Project(entity:GetLocation())
            if (project.X ~= -1.0 and project.Y ~= -1.0 and good_distance) then
                local count = table_count(Texts.items)
                Render.UpdateItemPosition(group_id, item_id, Vector2D(project.X, project.Y + math.floor(((Texts.items[func_name].custom_id - 1) - (count / 2))) * Each_Text_Y_Offset))
            else
                Render.ClearItems(group_id)
                Texts_On_Screen[class_name][entity:GetID()] = nil
            end
        else
            local new_text, custom_id = NewTextOnScreen(entity, class_name, Texts.group_id, item_text)
            if new_text then
                Texts.items[func_name] = {id = new_text, custom_id = custom_id}
            end
        end
    else
        local new_text, custom_id = NewTextOnScreen(entity, class_name, start_group_id, item_text)
        if new_text then
            Texts_On_Screen[class_name][entity:GetID()] = {
                group_id = start_group_id,
                items = {},
            }
            Texts_On_Screen[class_name][entity:GetID()].items[func_name] = {id = new_text, custom_id = custom_id}
            start_group_id = start_group_id + 1
        end
    end
end

function DrawGetFuncs(entity, class_name)
    local Funcs = VDEBUG_CLASSES[class_name].Get_Funcs
    if Funcs then
        for i, v in ipairs(Funcs) do
            --print(v)
            if entity[v] then
                local returned = {entity[v](entity)}
                DrawGetFuncOnScreen(entity, class_name, v, returned)
            else
                Package.Warn("vdebug : The function " .. v .. " is not callable in class " .. class_name)
            end
        end
    end
end


Client.Subscribe("Tick", function(ds)
    for k, v in pairs(VDEBUG_CLASSES) do
        if v.Get_Funcs then
            for k2, v2 in pairs(_ENV[k].GetPairs()) do
                DrawGetFuncs(v2, k)
            end
        end
    end
end)

if DEBUG_CLIENT_EVENTS then
    GenerateDebugEvents("Client_Events")
end

for k, v in pairs(VDEBUG_CLASSES) do
    if _ENV[k] then
        _ENV[k].Subscribe("Destroy", function(thing)
            if thing then
                if thing.GetID then
                    local id = thing:GetID()
                    if Texts_On_Screen[k] then
                        if Texts_On_Screen[k][id] then
                            Render.ClearItems(Texts_On_Screen[k][id].group_id)
                            Texts_On_Screen[k][id] = nil
                        end
                    end
                end
            end
        end)
    end
end

Package.Subscribe("Unload", function()
    for k, v in pairs(Texts_On_Screen) do
        for k2, v2 in pairs(v) do
            Render.ClearItems(v2.group_id)
        end
    end
end)