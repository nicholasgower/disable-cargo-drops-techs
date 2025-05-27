local rro = require("lib.remove-replace-object")
local function delete_tech(deleted_tech,new_tech)
    -- for _,effect in pairs(data.raw["technology"][deleted_tech].effects) do
    --     if effect.type == "unlock-recipe" then
    --         if new_tech then
    --             rro.soft_insert(data.raw["technology"][new_tech].effects, 
    --             {
    --                 type = "unlock-recipe",
    --                 recipe = data.raw["recipe"][effect.recipe].name,
    --             }
    --         )
    --         else
    --             data.raw["recipe"][effect.recipe].enabled = true
    --         end
    --     end
    -- end
    data.raw["technology"][deleted_tech] = nil
    local new_tech_exists = false
    if data.raw["technology"]["new-tech"] then
        new_tech_exists = true
    end
    for _,technology in pairs(data.raw["technology"]) do
        if new_tech_exists then
            rro.replace(technology.prerequisites,deleted_tech,new_tech)
        else
            rro.remove(technology.prerequisites,deleted_tech)
            
        end
        if technology.unit then
            for _,pack in pairs(technology.unit.ingredients) do
                if data.raw["technology"][pack[1]] then
                    rro.soft_insert(technology.prerequisites,pack[1])
                end
                
            end
        end
    end
end

local blacklist = {
    "planetslib-rubia-cargo-drops"
}

-- for _,item in pairs(blacklist) do
--     item = "planetslib-" .. item .. "-cargo-drops"
-- end

for key,tech in pairs(data.raw["technology"]) do 
    if string.find(key,"-cargo-drops",1,true) and not rro.contains(blacklist,key)  then
        local discovery_name = string.gsub(string.gsub(tech.name,"planetslib","planet-discovery"),"%-cargo%-drops","")
        if not data.raw["technology"][discovery_name] then
            discovery_name = string.gsub(string.gsub(tech.name,"planetslib","moon-discovery"),"%-cargo%-drops","")
        end
        --data.raw["technology"][key] = nil
        --tech = nil
        delete_tech(key,discovery_name)
    end
end
-- data.raw["technology"]["planetslib-cerys-cargo-drops"] = nil
-- data.raw["technology"]["planetslib-fulgora-cargo-drops"] = nil
-- data.raw["technology"]["planetslib-gleba-cargo-drops"] = nil
-- data.raw["technology"]["planetslib-vulcanus-cargo-drops"] = nil
-- --data.raw["technology"]["cerys-cargo-drops"] = nil