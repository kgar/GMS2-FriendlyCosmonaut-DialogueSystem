///@description create_dialogue_vStruct
function create_dialogue_vStruct(dialogue) {

	if(instance_exists(obj_textbox_vStruct)){ exit; }

	//Create the Textbox
	var _textbox = instance_create_layer(x,y, "Text", obj_textbox_vStruct);

	//Get Arguments
	var arg = 0, i = 0, arg_count = argument_count;
	repeat(arg_count){ arg[i] = argument[i]; i++; } 

	// Pass through the Sender as the default speaker
	var _sender = id;

	//Change the Textbox Values
	_textbox.dialogue = dialogue;
	with(_textbox){
		creator		= _sender;	
		draw_set_font(font[0]);
		charSize = string_width("M");
		stringHeight = string_height("M");
		event_perform(ev_alarm, 0);	//makes textbox perform "setup"
	}
	
	return _textbox;
}
