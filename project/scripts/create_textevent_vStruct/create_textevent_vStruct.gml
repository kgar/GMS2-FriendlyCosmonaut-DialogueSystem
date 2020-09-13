///@description create_textevent_vStruct
///@arg dialogue
function create_textevent(dialogue) {

	if(instance_exists(obj_textevent_vStruct)){ exit; }

	var textevent = instance_create_layer(0,0,"Instances",obj_textevent_vStruct);

	with(textevent){
		textEventDialogue = dialogue
	
		event_perform(ev_other, ev_user0);
	}

	return textevent;


}
