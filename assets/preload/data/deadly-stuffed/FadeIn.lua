function onCreatePost()
	makeLuaSprite("blocker", nil, 0, 0)
	setObjectCamera("blocker", 'hud')
	makeGraphic("blocker", screenWidth, screenHeight, '000000')
	addLuaSprite("blocker", true)
end

function onSongStart()
	doTweenAlpha("fadeTween", "blocker", 0, 8, "linear")
end

function onTweenCompleted(tag)
	if tag == "fadeTween" then
		removeLuaSprite("blocker", true)
	end
end