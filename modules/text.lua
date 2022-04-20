local TEXT = {}

function TEXT.write(node, text, speed, clear)
	speed = speed / 2
	local length, current_letter, text_timer = string.len(text), 1
	if clear then
		gui.set_text(node, "")
	end
	text_timer = timer.delay(speed, true, function()
		gui.set_text(node, gui.get_text(node)..string.sub(text, current_letter, current_letter))
		current_letter = current_letter + 1
		if current_letter > length then timer.cancel(text_timer) end
	end)
	return text_timer
end

TEXT.people_data = {
	agatha = {
		portrait = "agatha",
		name = "Agatha",
		actor = "Karolína Vávrová",
		text = "Zkušená hackerka podezřelá ze stovek případů kyberútoků, korporátní špionáže, krádeží a poškozování reklamních ploch."
	},
	claudia = {
		portrait = "claudia",
		name = "Claudia",
		actor = "Anna Procházková",
		text = "ERROR CODE 81-13-21:\nDATA NOT FOUND."
	},
	emmett = {
		portrait = "emmett",
		name = "Emmett Sanchez",
		actor = "Martin Bárta",
		text = "Dříve agent společnosti Proclive, současný zaměstnavatel neznámý. Extenzivní kybernetické implantáty jej činí velmi nebezpečným."
	},
	jack = {
		portrait = "jack",
		portrait_2 = "torrent",
		name = "Jack Torrent",
		actor = "Vojtěch Kynčl\nFilip Ryant",
		text = "Specialista na kyberinfiltraci a sociální inženýrství, poslední dobou zdánlivě neaktivní. Přiložen obrázek jeho avataru v kyberprostoru."
	},
	zanziro = {
		portrait = "zanziro",
		name = "Žanžiro",
		actor = "N/A",
		text = "Nebezpečný terorista, expert v boji s energetickým nano-mečem. Podle neověřených zpráv utrpěl při své poslední akci zranění neslučitelná s životem."
	},
	verkant = {
		portrait = "verkant",
		name = "Verkant Suillus III",
		actor = "Dušan Janovský",
		text = "Majitel AkordCorpu, vizionář, ztělesnění úspěchu. Obdařet géniem pro podnikání a výborným zdravotním stavem, Verkant Suillus jistě povede lidstvo a AkordCorp ke světlým zítřkům."
	},
	arkadij = {
		portrait = "arkadij",
		name = "Arkadij",
		actor = "Pavel Pipek",
		text = "Šéf bezpečnostní agentury A-Sec. Vyzbrojen špičkovým bojovým výcvikem a nejlepším vybavením jaké lze pořídit, Arkadij je první linií obrany AkordCorpu před nepřáteli všeho druhu."
	},
	holkogramy = {
		portrait = "holkogram_1",
		portrait_2 = "holkogram_2",
		name = "Holkogramy",
		actor = "Eliška Konečná\nEvča Horčičková",
		text = "Od reklamních prezentací, přes komunikaci se spotřebiteli až po vojenské asistenční programy, Holkogramy od AkordCorpu jsou tu pro Vás."
	},
	fhill = {
		portrait = "fhill",
		name = "Richard K. Fhill",
		actor = "Alex Fedosov",
		text = "Jeden z milionů zaměstnanců AkordCorpu na zemi i jinde, zaměstnanec J3N-M450 s úsměvem na tváři pracuje dnem i nocí, abyste si mohli užít Vaše oblíbené produkty AkordCorpu."
	}
}

return TEXT