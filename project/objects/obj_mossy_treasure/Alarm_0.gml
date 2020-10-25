/// @description Open Chest Animation

if (animationIndex == array_length(animationScheme)) {
	onOpeningAnimationComplete();
	return;
}

var animationStep = animationScheme[animationIndex];

treasureImageIndex = animationStep.subImg;
 
var framesToWait = getFramesToWait(animationStep.ms);
animationIndex++;
alarm[0] = framesToWait;
