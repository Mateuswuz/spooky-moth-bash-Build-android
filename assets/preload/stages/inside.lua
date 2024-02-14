function onCreate()
    local folder = 'stages/inside/'
    local letterboxSize = 100


    makeLuaSprite('stars', folder..'3', -300, -300);
	scaleObject('stars', 0.9, 0.9)
	setScrollFactor('stars', 0.7, 0.7);
    addLuaSprite('stars', false);

    makeLuaSprite('inside', folder..'1', -300, -300);
	scaleObject('inside', 0.9, 0.9)
	setScrollFactor('inside', 0.99, 0.99);
    addLuaSprite('inside', false);

    makeLuaSprite('blur1', folder..'2', -300, -300);
	scaleObject('blur1', 0.9, 0.9)
	setScrollFactor('blur1', 0.99, 0.99);
    addLuaSprite('blur1', true);

    makeLuaSprite('blur2', folder..'4', -300, -300);
	scaleObject('blur2', 0.9, 0.9)
	setScrollFactor('blur2', 0.99, 0.99);
    addLuaSprite('blur2', true);

    setObjectOrder('boyfriendGroup', getObjectOrder('dadGroup') - 1)

    makeLuaSprite("letterboxTop", nil, 0, 0)
    makeLuaSprite("letterboxBottom", nil, 0, screenHeight)
    setObjectCamera("letterboxTop", 'hud')
    setObjectCamera("letterboxBottom", 'hud')
    makeGraphic("letterboxTop", screenWidth, letterboxSize, '000000')
    makeGraphic("letterboxBottom", screenWidth, letterboxSize, '000000')
    updateHitbox("letterboxTop")
    updateHitbox("letterboxBottom")
    setProperty("letterboxBottom.y", getProperty("letterboxBottom.y") - getProperty("letterboxBottom.height"))
    addLuaSprite("letterboxTop", false)
    addLuaSprite("letterboxBottom", false)
end