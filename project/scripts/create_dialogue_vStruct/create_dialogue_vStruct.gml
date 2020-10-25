///@description create_dialogue_vStruct
function create_dialogue_vStruct(_dialogue, _caller) {

	if(instance_exists(obj_textbox_vStruct)){ return; }

	//Create the Textbox
	var _textbox = instance_create_layer(1, 1, "Text", obj_textbox_vStruct);
	_textbox.Init(_dialogue, _caller);
	return _textbox;
}
