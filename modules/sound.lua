local SND = {}

local gated_sounds = {}
local sound_gating_delay = 0.05

function SND.play(sound_path)
	if not gated_sounds[sound_path] then
		sound.play(sound_path)
		gated_sounds[sound_path] = true
		timer.delay(sound_gating_delay, false, function()
			gated_sounds[sound_path] = nil
		end)
	end
end

return SND