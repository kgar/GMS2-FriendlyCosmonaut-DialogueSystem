///@description create_dialogue_vStruct
function create_dialogue_vStruct(dialogue) {

	if(instance_exists(obj_textbox_vStruct)){ exit; }

	//Create the Textbox
	var _textbox = instance_create_layer(x,y, "Text", obj_textbox_vStruct);

	//Change the Textbox Values
	_textbox.dialogue = dialogue;
	event_perform_object(_textbox, ev_alarm, 0);
	
	return _textbox;
}
