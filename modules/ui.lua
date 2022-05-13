local UI = {active = {}}

UI.COLOUR_DEFAULT = vmath.vector4(0.05, 0.45, 0.05, 1)
UI.COLOUR_DISABLED = vmath.vector4(0.2, 0.2, 0.2, 1)
UI.COLOUR_ERROR = vmath.vector4(0.35, 0.75, 0.15, 1)
UI.COLOUR_WHITE = vmath.vector4(1)
UI.COLOUR_BLACK = vmath.vector4(0, 0, 0, 1)

UI.SCAN_TIME = 5

function UI.load_template(template)
	local node, node_text
	if type(template) == "table" then
		for key, val in ipairs(template) do
			UI.load_template(val)
		end
		return
	end
	local state, type = true
	if pcall(gui.get_node, template.."/button_box") then
		node = gui.get_node(template.."/button_box")
		type = hash("button")
	elseif pcall(gui.get_node, template.."/button_map") then
		node = gui.get_node(template.."/button_map")
		type = hash("button_map")
	elseif pcall(gui.get_node, template.."/button_black") then
		node = gui.get_node(template.."/button_black")
		type = hash("button_black")
	elseif pcall(gui.get_node, template.."/button_white") then
		node = gui.get_node(template.."/button_white")
		type = hash("button_white")
	end
	table.insert(UI.active, {template = template, type = type, state = state, node = node})
end

function UI.unload_template(template)
	if template then
		if type(template) == "table" then
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

local text_field
local text_field_text = ""
local char_limit
local cursor_timer
local cursor_visible = false
local placeholder_text = ""

local function text_field_cursor()
	cursor_visible = not cursor_visible
	if cursor_visible then
		gui.set_text(text_field, text_field_text.."|")
	else
		gui.set_text(text_field, text_field_text)
	end
	cursor_timer = timer.delay(0.5, false, text_field_cursor)
end

function UI.enable_text_field(node, remove_text, set_char_limit, placeholder)
	placeholder_text = placeholder or ""
	char_limit = set_char_limit
	text_field = node
	if remove_text then
		text_field_text = ""
	else
		text_field_text = gui.get_text(node)
	end
	gui.show_keyboard(gui.KEYBOARD_TYPE_DEFAULT, false)
	cursor_visible = false
	text_field_cursor()
end

function UI.disable_text_field(remove_text)
	gui.hide_keyboard()
	if text_field then
		if remove_text then
			gui.set_text(text_field, remove_text)
			text_field_text = placeholder_text
		else
			if #text_field_text > 0 then
				gui.set_text(text_field, text_field_text)
			else
				gui.set_text(text_field, placeholder_text)
			end
		end
		timer.cancel(cursor_timer)
		text_field = nil
		char_limit = nil
	end
end

function UI.check_text_field(x, y)
	if text_field and not gui.pick_node(text_field, x, y) then
		UI.disable_text_field()
	end
end

function UI.enter_text(text)
	if text_field then
		local new_text = text_field_text..text
		if char_limit and #new_text > char_limit then
			return
		end
		text_field_text = new_text
		gui.set_text(text_field, text_field_text)
		timer.cancel(cursor_timer)
		cursor_visible = false
		text_field_cursor()
	end
end

function UI.backspace()
	if text_field and #text_field_text > 0 then
		text_field_text = string.sub(text_field_text, 1, -2)
		gui.set_text(text_field, text_field_text)
		timer.cancel(cursor_timer)
		cursor_visible = false
		text_field_cursor()
	end
end

function UI.reset_text_field(node)
	gui.set_text(node, placeholder_text)
end

return UI