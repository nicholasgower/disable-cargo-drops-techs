for _,tech in pairs(data.raw["technology"]) do 
    if string.find(tech.name,"-cargo-drops") then
        tech = nil
    end
end
data.raw["technology"]["cerys-cargo-drops"] = nil