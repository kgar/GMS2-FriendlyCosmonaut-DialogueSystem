if(global.dialogue_functions.textevent_already_underway()) { 
	instance_destroy(); 
	exit; 
}

myTextbox   = noone;

function Init(_dialogue) {
	myTextbox = create_dialogue_vStruct(_dialogue);
}