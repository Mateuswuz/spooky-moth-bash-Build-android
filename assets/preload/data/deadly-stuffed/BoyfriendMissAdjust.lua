--cursed thing by IceDoodleGuy
ignoreNotes = {"skid", "skid2"}
animSpeed = 24

leftAnim = "missleft"
downAnim = "missdown"
upAnim = "missup"
rightAnim = "missright"

leftOffset = {-18,1}
downOffset = {-30,-10}
upOffset = {-30, 50}
rightOffset = {-60, 10}

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

function checkHitNote(type)
	for i = 1, #ignoreNotes do
		if tostring(type) == ignoreNotes[i] then
			return true
		end
	end
	return false
end

function noteMiss(id, direction, noteType, isSustainNote)
	if not checkHitNote(noteType) then
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