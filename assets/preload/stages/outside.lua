function onCreate() --this sucks please dont look at it :face_holding_back_tears:
    local folder = 'stages/outside/'
    
    makeLuaSprite('blur3', folder..'6', -300, -300);
	setScrollFactor('blur3', 0.99, 0.99);
    scaleObject('blur3', 1.8, 1.8)
    addLuaSprite('blur3', false);

    makeLuaSprite('stars', folder..'3', -300, -300);
    scaleObject('stars', 1.8, 1.8)
	setScrollFactor('stars', 0.85, 0.85);
    addLuaSprite('stars', false);

    makeLuaSprite('blur1', folder..'2', -300, -300);
    scaleObject('blur1', 1.8, 1.8)
	setScrollFactor('blur1', 0.85, 0.85);
    addLuaSprite('blur1', false);

    makeLuaSprite('inside', folder..'1', -300, -300);
    scaleObject('inside', 1.8, 1.8)
	setScrollFactor('inside', 0.99, 0.99);
    addLuaSprite('inside', false);

    
    makeLuaSprite('blur2', folder..'4', 360, 0);
    scaleObject('blur2', 1.8, 1.8)
	setScrollFactor('blur2', 0.99, 0.99);
    addLuaSprite('blur2', true);


    makeLuaSprite('blur5', folder..'5', -300, -300);
    scaleObject('blur5', 1.8, 1.8)
	setScrollFactor('blur5', 0.99, 0.99);
    addLuaSprite('blur5', true);

    setObjectOrder('dadGroup', getObjectOrder('gfGroup'))
    setObjectOrder('gfGroup', getObjectOrder('gfGroup')-1)
end

function onCreatePost()
    bgStartPosX = getProperty("inside.x")
    bgStartPosY = getProperty("inside.y")
    bgWidth = getProperty("inside.width")
    bgHeight = getProperty("inside.height")

    orderTable = {{"1", "R"}, {"2", "L"}, {"3", "L"}, {"4", "L"}, {"5", "L"}, {"6", "R"}, {"7", "R"}, {"8", "R"}, {"9", "L"} }
    bgOrderTable = {{"1", "R"}, {"2", "R"}, {"3", "L"}, {"4", "R"}, {"5", "R"}, {"6", "L"}, {"7", "R"}, {"8", "L"}, {"9", "R"}, {"10", "R"}, {"11", "R"}, {"12", "R"}, {"13", "R"}, {"14", "L"}, {"15", "R"}, {"16", "L"}, {"17", "L"}, {"18", "L"}}
    count = 0
    countB = 0

    fgCharSpeed = 13

    bgCharSpeed = 3.25
    bgCharAlignType = "sineInOut"
    bgCharLowerRand = 1
    bgCharUpperRand = 5
    bgCharApexOffset = 725
    bgCharStartEndOffset = 825

    for i = 1,11 do 
        precacheImage("stages/outside/cameos/fg/" .. tostring(i))
    end
    for i = 1,17 do
        precacheImage("stages/outside/cameos/bg/" .. tostring(i))
    end


    makeLuaSprite("fgChar", "stages/outside/cameos/fg/1", 0, 0)
    updateHitbox("fgChar")
    fgCharWidth = getProperty("fgChar.width")

    setProperty("fgChar.x", bgStartPosX + bgWidth)
    setProperty("fgChar.y",bgStartPosY + (bgHeight - getProperty("fgChar.height")) - 50)
    setObjectCamera("fgChar", 'game')
    setScrollFactor("fgChar", 0.99, 0.99)
    fgCharInitY = getProperty("fgChar.y")

    addLuaSprite("fgChar", true)

    makeLuaSprite("bgChar", "stages/outside/cameos/bg/1", 0, 0)
    scaleObject("bgChar", 1.3, 1.3, true)
    bgCharWidth = getProperty("bgChar.width")
    bgCharHeight = getProperty("bgChar.height")

    setProperty("bgChar.x", bgStartPosX + bgWidth)
    setProperty("bgChar.y", bgStartPosY + bgCharStartEndOffset)
    setObjectCamera("bgChar", 'game')
    setScrollFactor("bgChar", 0.99, 0.99)

    addLuaSprite("bgChar", false)

    makeLuaSprite("spongeChar", "stages/outside/cameos/fg/10", 0, 0)
    updateHitbox("spongeChar")
    spongeCharWidth = getProperty("spongeChar.width")

    setProperty("spongeChar.x", bgStartPosX + bgWidth)
    setProperty("spongeChar.y",bgStartPosY + (bgHeight - getProperty("spongeChar.height")) - 50)
    setObjectCamera("spongeChar", 'game')
    setScrollFactor("spongeChar", 0.99, 0.99)
    spongeCharInitY = getProperty("spongeChar.y")

    addLuaSprite("spongeChar", true)
end

function rightChar(charImg)
    loadGraphic("fgChar", "stages/outside/cameos/fg/" .. charImg)
    setProperty("fgChar.x", bgStartPosX + bgWidth)
    doTweenX("fgCharWalk", "fgChar",  bgStartPosX - fgCharWidth, fgCharSpeed, "linear")
end

function leftChar(charImg)
    loadGraphic("fgChar", "stages/outside/cameos/fg/" .. charImg)
    setProperty("fgChar.x", bgStartPosX - fgCharWidth)
    doTweenX("fgCharWalk", "fgChar", bgStartPosX + bgWidth, fgCharSpeed, "linear")
end

function rightBgChar(charImg)
    loadGraphic("bgChar", "stages/outside/cameos/bg/" .. charImg)
    setProperty("bgChar.x", bgStartPosX + bgWidth)
    setProperty("bgChar.y", bgStartPosY + bgCharStartEndOffset)
    doTweenX("bgCharWalkR1", "bgChar", (bgStartPosX + (bgWidth / 2)) - (bgCharWidth / 2), bgCharSpeed, "linear")
    doTweenY("bgCharAlign", "bgChar", bgStartPosY + bgCharApexOffset, bgCharSpeed, bgCharAlignType)
end

function leftBgChar(charImg)
    loadGraphic("bgChar", "stages/outside/cameos/bg/" .. charImg)
    setProperty("bgChar.x", bgStartPosX - bgCharWidth)
    setProperty("bgChar.y", bgStartPosY + bgCharStartEndOffset)
    doTweenX("bgCharWalkL1", "bgChar", (bgStartPosX + (bgWidth / 2)) - (bgCharWidth / 2), bgCharSpeed, "linear")
    doTweenY("bgCharAlign", "bgChar", bgStartPosY + bgCharApexOffset, bgCharSpeed, bgCharAlignType)
end

function onSongStart()
    spawnFgChar()
    spawnBgChar()
end

function onBeatHit()
    if luaSpriteExists("fgChar") then
        setProperty("fgChar.y", fgCharInitY + 50)
        doTweenY("bbpanzucore", "fgChar", fgCharInitY, 0.5, "expoOut")
    end

    if luaSpriteExists("spongeChar") then
        setProperty("spongeChar.y", spongeCharInitY + 50)
        doTweenY("spongebbpanzucore", "spongeChar", spongeCharInitY, 0.5, "expoOut")
    end

    if luaSpriteExists("bgChar") then
        if curBeat % 2 == 1 then
        setProperty("bgChar.angle", 5)
        else
            setProperty("bgChar.angle", -5)
        end
    end
end


function onTweenCompleted(tag)
    if tag == "fgCharWalk" then
        spawnFgChar()
    elseif tag == "bgCharWalkR1" then
        doTweenX("bgCharWalkR2", "bgChar",  bgStartPosX - bgCharWidth, bgCharSpeed, "linear")
        doTweenY("bgCharAlignPart2", "bgChar", bgStartPosY + bgCharStartEndOffset, bgCharSpeed, bgCharAlignType)
    elseif tag == "bgCharWalkL1" then
        doTweenX("bgCharWalkL2", "bgChar", bgStartPosX + bgWidth, bgCharSpeed, "linear")
        doTweenY("bgCharAlignPart2", "bgChar", bgStartPosY + bgCharStartEndOffset, bgCharSpeed, bgCharAlignType)
    elseif tag == "bgCharWalkL2" or tag == "bgCharWalkR2" then
        spawnBgChar()
    end
end

function spawnFgChar()
    count = count + 1

    currentChar = orderTable[count]

    if count <= #orderTable then
        if currentChar[2] == "R" then
            rightChar(currentChar[1])
        elseif currentChar [2] == "L" then
            leftChar(currentChar[1])
        end
    end
end

function spawnBgChar()
    countB = countB + 1

    currentChar = bgOrderTable[countB]

    if countB <= #bgOrderTable then
        if currentChar[2] == "R" then
            rightBgChar(currentChar[1])
        elseif currentChar [2] == "L" then
            leftBgChar(currentChar[1])
        end
    end
end

function onStepHit()
    if curStep == 832 then
        doTweenX("spongeCharWalk", "spongeChar",  bgStartPosX - spongeCharWidth, fgCharSpeed, "linear")
    end
    if curStep == 888 then
        runHaxeCode([[
            setVar('fgCharTweenPercent', PlayState.instance.modchartTweens["spongeCharWalk"].percent);
            ]])
        spongeTweenPercent = getProperty('fgCharTweenPercent')
        cancelTween("spongeCharWalk")
        loadGraphic("spongeChar", "stages/outside/cameos/fg/11")
        runTimer("spongeTimer", 0.75)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "spongeTimer" then
        loadGraphic("spongeChar", "stages/outside/cameos/fg/10")
        doTweenX("spongeCharWalk", "spongeChar",  bgStartPosX - spongeCharWidth, fgCharSpeed - (fgCharSpeed * tonumber(spongeTweenPercent)), "linear")
    end
end