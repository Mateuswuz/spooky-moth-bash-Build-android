function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'pico' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true) --dont animate the 'actual' chars
		end
	end
end