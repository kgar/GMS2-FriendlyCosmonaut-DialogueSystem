///@description create_dialogue_vStruct
function create_dialogue_vStruct(_dialogue) {

	if(instance_exists(obj_textbox_vStruct)){ exit; }

	//Create the Textbox
	var _textbox = instance_create_layer(x,y, "Text", obj_textbox_vStruct);
	_textbox.Init(_dialogue);
	return _textbox;
}
