function onCreatePost()
	makeLuaSprite("blocker", nil, 0, 0)
	setObjectCamera("blocker", 'hud')
	makeGraphic("blocker", screenWidth, screenHeight, '000000')
    setProperty("blocker.alpha", 0)
	addLuaSprite("blocker", true)
end

function onStepHit()
    if curStep == 1151 then
		debugPrint("asdf")
        doTweenAlpha("fadeTween", "blocker", 1, 12.5, "expoIn")
		debugPrint("ghjk")
    end
end