--cursed thing by IceDoodleGuy
ignoreNote = "pico"
animSpeed = 24

leftAnim = "missleft"
downAnim = "missdown"
upAnim = "missup"
rightAnim = "missright"

leftOffset = {42,-9}
downOffset = {201,-70}
upOffset = {-40, 20}
rightOffset = {-20, -10}

function onCreatePost()
    makeOffsets()
    setProperty("boyfriend.hasMissAnimations", false)
    addAnimationByPrefix("boyfriend", 'singLEFTmiss_fake', leftAnim, animSpeed, false);
	addAnimationByPrefix("boyfriend", 'singDOWNmiss_fake', downAnim, animSpeed, false);
	addAnimationByPrefix("boyfriend", 'singUPmiss_fake', upAnim, animSpeed, false);
	addAnimationByPrefix("boyfriend", 'singRIGHTmiss_fake', rightOffset, animSpeed, false);
    objectPlayAnimation("boyfriend", "idle", true, 0);
end

offsets = {};
function makeOffsets()
	offsets[0] = {x = leftOffset[1], y = leftOffset [2]}; --left
	offsets[1] = {x = downOffset[1], y = downOffset[2]}; --down
	offsets[2] = {x = upOffset[1], y = upOffset[2]}; --up
	offsets[3] = {x = rightOffset[1], y = rightOffset[2]}; --right
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType ~= ignoreNote then
        if direction == 0 then
            playAnim("boyfriend", "singLEFTmiss_fake", true)
        elseif direction == 1 then
            playAnim("boyfriend", "singDOWNmiss_fake", true)
        elseif direction == 2 then
            playAnim("boyfriend", "singUPmiss_fake", true)
        elseif direction == 3 then
            playAnim("boyfriend", "singRIGHTmiss_fake", true)
        else
        debugPrint("???")
        end
        setProperty("boyfriend" .. '.offset.x', offsets[direction].x);
        setProperty("boyfriend" .. '.offset.y', offsets[direction].y);
	end
end

function noteMissPress(direction)
    if direction == 0 then
        playAnim("boyfriend", "singLEFTmiss_fake", true)
    elseif direction == 1 then
        playAnim("boyfriend", "singDOWNmiss_fake", true)
    elseif direction == 2 then
        playAnim("boyfriend", "singUPmiss_fake", true)
    elseif direction == 3 then
        playAnim("boyfriend", "singRIGHTmiss_fake", true)
    else
    debugPrint("???")
    end
    setProperty("boyfriend" .. '.offset.x', offsets[direction].x);
    setProperty("boyfriend" .. '.offset.y', offsets[direction].y);
end