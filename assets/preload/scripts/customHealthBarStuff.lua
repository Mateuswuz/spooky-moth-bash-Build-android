function onCreatePost()
    if string.lower(songName) == "deadly stuffed" then graphic = "healthBarOverlay2" else graphic = "healthBarOverlay1" end
    makeLuaSprite("healthBarOverlay", "healthOverlays/" .. graphic, -30, - 60)
    setObjectCamera("healthBarOverlay", "hud")
    runHaxeCode([[game.healthBar.add(game.modchartSprites.get("healthBarOverlay"));]]) --this feels cursed
end