if(global.dialogue_functions.textevent_already_underway()) { 
	instance_destroy(); 
	exit; 
}

//-----------Customise (FOR USER)
myVoice			= snd_voice2;
myTextCol		= c_white;
myPortrait		= -1;
myFont			= fnt_dialogue;
myName			= "None";

//-----------Setup (LEAVE THIS STUFF)
myTextbox   = noone;
dialogue = undefined;