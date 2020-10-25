if(!keyboard_check_pressed(global.interactKey)){
	return;
}

var dr = detectionRadius;
if(point_in_rectangle(playerObject.x, playerObject.y, x-dr, y-dr, x+dr, y+dr)){
	onPlayerInteraction();
}