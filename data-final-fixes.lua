for _,tech in pairs(data.raw["technology"]) do 
    if string.find(tech.name,"-cargo-drops") then
        tech = nil
    end
end
data.raw["technology"]["planetslib-cerys-cargo-drops"] = nil
data.raw["technology"]["planetslib-fulgora-cargo-drops"] = nil
data.raw["technology"]["planetslib-gleba-cargo-drops"] = nil
data.raw["technology"]["planetslib-vulcanus-cargo-drops"] = nil
--data.raw["technology"]["cerys-cargo-drops"] = nil