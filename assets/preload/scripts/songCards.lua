function onCreate()
    songs = {"deadly stuffed", "funker treat"}
    songCards = {"deadlyStuffedCard", "funkerTreatCard"}
    animXmlNames = {"deadlyStuffed instance", "funkerTreat"}
    songId = nil
    for i = 1, #songs do
        if string.lower(songName) == songs[i] then
            songId = i
            break
        end
    end
    if songId ~= nil then 
        makeAnimatedLuaSprite("songCard", "songCards/" .. songCards[songId], -277, screenHeight / 4)
        setObjectCamera("songCard", "other")
        scaleObject("songCard", 0.5, 0.5)
        addAnimationByPrefix("songCard", "comeIn", animXmlNames[songId], 24, false)
        setProperty("songCard.visible", false)
        addLuaSprite("songCard", false)
    end
end

function onSongStart()
    if songId ~= nil then
        playAnim("songCard", "comeIn", true, false, 0)
        setProperty("songCard.visible", true)
        runTimer("cardKillTimer", 4, 1)
    end
end


function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "cardKillTimer" then
        removeLuaSprite("songCard", true)
    end
end