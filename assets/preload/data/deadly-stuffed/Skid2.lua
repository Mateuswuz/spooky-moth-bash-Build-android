-- Script by Shadow Mario
-- Customized for Simplicity by Kevin Kuntz
-- Horrific retooling by ice
-- This is the player version graaah!!!
--VARIABLES
charTag = "skid2"
charSheetName = "skid2"

idleXMLName = "idle0"
leftXMLName = "left0"
downXMLName = "down0"
rightXMLName = "right0"
upXMLname = "up0"
leftMissXMLName = "missleft0"
downMissXMLName = "missdown0"
rightMissXMLName = "missright0"
upMissXMLname = "missup0"

noteTriggers = {"skid", "skid2"}

animSpeed = 24
--OFFSETS
spawnPosX = 880 --880
spawnPosY = 90 --90

scaleFactorX = 1
scaleFactorY = 1

idleOffsetX = 0
idleOffsetY = 0
leftOffsetX = 96
leftOffsetY = -17
downOffsetX = -3
downOffsetY = -18
upOffsetX = 109
upOffsetY = 242
rightOffsetX = -61
rightOffsetY = 60

leftMissOffsetX = 60
leftMissOffsetY = 50
downMissOffsetX = 20
downMissOffsetY = -20
upMissOffsetX = 70
upMissOffsetY = 160
rightMissOffsetX = -40
rightMissOffsetY = 50
--ACTUAL CODE SWAG !!!

function onCreate()
	makeAnimationList();
	makeOffsets();
	makeAnimatedLuaSprite(charTag, 'characters/'.. charSheetName, spawnPosX, spawnPosY);
	setProperty(charTag .. '.antialiasing', true)
	scaleObject(charTag,scaleFactorX,scaleFactorY)
	setObjectOrder(charTag, 7)
	addAnimationByPrefix(charTag, 'idle', idleXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singLEFT', leftXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singDOWN', downXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singUP', upXMLname, animSpeed, false);
	addAnimationByPrefix(charTag, 'singRIGHT', rightXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singLEFTmiss', leftMissXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singDOWNmiss', downMissXMLName, animSpeed, false);
	addAnimationByPrefix(charTag, 'singUPmiss', upMissXMLname, animSpeed, false);
	addAnimationByPrefix(charTag, 'singRIGHTmiss', rightMissXMLName, animSpeed, false);
	addLuaSprite(charTag);
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
	animationsList[5] = 'singLEFTmiss';
	animationsList[6] = 'singDOWNmiss';
	animationsList[7] = 'singUPmiss';
	animationsList[8] = 'singRIGHTmiss';
end

offsets = {};
function makeOffsets()
	offsets[0] = {x = idleOffsetX, y = idleOffsetY}; --idle
	offsets[1] = {x = leftOffsetX, y = leftOffsetY}; --left
	offsets[2] = {x = downOffsetX, y = downOffsetY}; --down
	offsets[3] = {x = upOffsetX, y = upOffsetY}; --up
	offsets[4] = {x = rightOffsetX, y = rightOffsetY}; --right
	offsets[5] = {x = leftMissOffsetX, y = leftMissOffsetY};
	offsets[6] = {x = downMissOffsetX, y = downMissOffsetY};
	offsets[7] = {x = upMissOffsetX, y = upMissOffsetY};
	offsets[8] = {x = rightMissOffsetX, y = rightMissOffsetY};
end

function checkHitNote(type)
	for i = 1, #noteTriggers do
		if tostring(type) == noteTriggers[i] then
			return true
		end
	end
	return false
end

function goodNoteHit(id, direction, noteType, isSustainNote)
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

function noteMiss(id, direction, noteType, isSustainNote)
	if checkHitNote(noteType) then
		if not isSustainNote then
			noteDatas.char = direction;
		end	
	characterToPlay = charTag
	animToPlay = noteDatas.char + 5;
	holdTimers.char = 0;
			
	playAnimation(characterToPlay, animToPlay, true);
	end
end

function noteMissPress(direction)
	noteDatas.char = direction;
	characterToPlay = charTag
	animToPlay = noteDatas.char + 5;
	holdTimers.char = 0;	
	playAnimation(characterToPlay, animToPlay, true);
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