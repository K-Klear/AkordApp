local UI = {active = {}}

function UI.load_template(template)
	if type(template) == "table" then
		for key, val in ipairs(template) do
			UI.load_template(val)
		end
		return
	end
	local type
	if pcall(gui.get_node, template.."/checkbox") then
		type = hash("checkbox")
	end
	table.insert(UI.active, {template = template, type = type, state = true})
end

return UI