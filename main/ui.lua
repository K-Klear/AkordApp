local UI = {active = {}}

function UI.load_template(template)
	if type(template) == "table" then
		for key, val in ipairs(template) do
			UI.load_template(val)
		end
		return
	end
	local state, type = true
	if pcall(gui.get_node, template.."/checkbox") then
		type = hash("checkbox")
		state = gui.get_flipbook(gui.get_node(template.."/checkbox")) == hash("check_true")
	elseif pcall(gui.get_node, template.."/button_box") then
		type = hash("button")
	end
	table.insert(UI.active, {template = template, type = type, state = state})
end

function UI.unload_template(template)
	if template then
		if type(template) then
			for key, val in ipairs(template) do
				UI.unload_template(val)
			end
			return
		else
			for key, val in ipairs(UI.active) do
				if val.template == template then
					table.remove(UI.active, key)
					return
				end
			end
		end
	else
		UI.active = {}
	end
end

return UI