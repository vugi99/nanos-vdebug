
local Tick_Canvas = Canvas(
    true,
    Color.TRANSPARENT,
    0,
    true
)

local Texts_On_Screen = {}

Tick_Canvas:Subscribe("Update", function(self, width, height)
    Texts_On_Screen = {}
    for k, v in pairs(VDEBUG_CLASSES) do
        if v.Get_Funcs then
            Texts_On_Screen[k] = {}
        end
    end

    for k, v in pairs(VDEBUG_CLASSES) do
        if v.Get_Funcs then
            for k2, v2 in pairs(_ENV[k].GetPairs()) do
                DrawGetFuncs(v2, k)
            end
        end
    end

    for k, v in pairs(Texts_On_Screen) do
        for k2, v2 in pairs(v) do
            local count = table_count(v2.items)
            for k3, v3 in pairs(v2.items) do
                self:DrawText(
                    v3.item_text,
                    Vector2D(v3.project.X, v3.project.Y + math.floor(((v3.custom_id - 1) - (count / 2))) * Each_Text_Y_Offset),
                    FontType.Roboto,
                    Screen_Text_Font_Size,
                    Color(1, 1, 1),
                    0,
                    true,
                    true,
                    Color.BLACK,
                    Vector2D(0, 0),
                    false,
                    Color.BLACK
                )
            end
        end
    end
end)

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

function NewTextOnScreen(entity, class_name)
    local project = Client.ProjectWorldToScreen(entity:GetLocation())
    local good_distance = IsGoodDistance(entity)
    if (project and project.X ~= -1.0 and project.Y ~= -1.0 and good_distance) then
        local count = 0
        if Texts_On_Screen[class_name][entity:GetID()] then
            count = table_count(Texts_On_Screen[class_name][entity:GetID()].items)
        end
        return count + 1, project
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
    local custom_id, project = NewTextOnScreen(entity, class_name)
    if custom_id then
        if not Texts then
            Texts_On_Screen[class_name][entity:GetID()] = {
                items = {},
            }
        end
        Texts_On_Screen[class_name][entity:GetID()].items[func_name] = {custom_id = custom_id, project = project, item_text = item_text}
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

if DEBUG_CLIENT_EVENTS then
    GenerateDebugEvents("Client_Events")
end