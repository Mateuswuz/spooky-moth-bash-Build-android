-- Script by Shadow Mario
-- Customized for Simplicity by Kevin Kuntz
-- Horrific retooling by ice
-- This is the opponent version graaah!!!
--VARIABLES
charTag = "skid"
charSheetName = "skid"

idleXMLName = "idle0"
leftXMLName = "left0"
downXMLName = "down0"
rightXMLName = "right0"
upXMLname = "up0"

noteTriggers = {"skid", "skid2"}

animSpeed = 24
--OFFSETS
spawnPosX = 560
spawnPosY = 970

scaleFactorX = 1
scaleFactorY = 1

idleOffsetX = 0
idleOffsetY = 0
leftOffsetX = 46
leftOffsetY = 13
downOffsetX = 17
downOffsetY = -38
upOffsetX = -44
upOffsetY = 64
rightOffsetX = 9
rightOffsetY = 0
--ACTUAL CODE SWAG !!!

function onCreate()
	makeAnimationList();
	makeOffsets();
	makeAnimatedLuaSprite(charTag, 'characters/'.. charSheetName, spawnPosX, spawnPosY);
	setProperty(charTag .. '.antialiasing', true)
	scaleObject(charTag,scaleFactorX,scaleFactorY)
	--setObjectOrder(charTag, 3)
	addAnimationByPrefix(charTag, 'idle', idleXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singLEFT', leftXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singDOWN', downXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singUP', upXMLname, animSpeed, false);
	addAnimationByPrefix(charTag, 'singRIGHT', rightXMLName, animSpeed, false);
	addLuaSprite(charTag, true);
	playAnimation(charTag, 0, true);
end

animationsList = {}
holdTimers = {char = -1.0};
noteDatas = {char = 0};
function makeAnimationList()
	animationsList[0] = 'idle';
	animationsList[1] = 'singLEFT';
	animationsList[2] = 'singDOWN';
	animationsList[3] = 'singUP';
	animationsList[4] = 'singRIGHT';
end

offsets = {};
function makeOffsets()
	offsets[0] = {x = idleOffsetX, y = idleOffsetY}; --idle
	offsets[1] = {x = leftOffsetX, y = leftOffsetY}; --left
	offsets[2] = {x = downOffsetX, y = downOffsetY}; --down
	offsets[3] = {x = upOffsetX, y = upOffsetY}; --up
	offsets[4] = {x = rightOffsetX, y = rightOffsetY}; --right
end

function checkHitNote(type)
	for i = 1, #noteTriggers do
		if tostring(type) == noteTriggers[i] then
			return true
		end
	end
	return false
end


function opponentNoteHit(id, direction, noteType, isSustainNote)
	if checkHitNote(noteType) then
		if not isSustainNote then
			noteDatas.char = direction;
		end	
	characterToPlay = charTag
	animToPlay = noteDatas.char + 1;
	holdTimers.char = 0;
			
	playAnimation(characterToPlay, animToPlay, true);
	end
end


function onUpdate(elapsed)
	holdCap = stepCrochet * 0.004;
	if holdTimers.char >= 0 then
		holdTimers.char = holdTimers.char + elapsed;
		if holdTimers.char >= holdCap then
			playAnimation(charTag, 0, false);
			holdTimers.char = -1;
		end
	end
end

function onCountdownTick(counter)
	beatHitDance(counter);
end

function onBeatHit()
	beatHitDance(curBeat);
end

function beatHitDance(counter)
	if counter % 2 == 0 then
		if holdTimers.char < 0 then
			playAnimation(charTag, 0, false);
		end
	end
end

function playAnimation(character, animId, forced)
	-- 0 = idle
	-- 1 = singLEFT
	-- 2 = singDOWN
	-- 3 = singUP
	-- 4 = singRIGHT
	animName = animationsList[animId];
	--debugPrint(animName);
	if character == charTag then
		objectPlayAnimation(charTag, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)
		setProperty(charTag .. '.offset.x', offsets[animId].x);
		setProperty(charTag .. '.offset.y', offsets[animId].y);
	end
end