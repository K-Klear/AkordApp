local TEXT = {}

function TEXT.write(node, text, speed)
	speed = speed / 2
	local length, current_letter, text_timer = string.len(text), 1
	text_timer = timer.delay(speed, true, function()
		gui.set_text(node, gui.get_text(node)..string.sub(text, current_letter, current_letter))
		current_letter = current_letter + 1
		if current_letter > length then timer.cancel(text_timer) end
	end)
end

return TEXT