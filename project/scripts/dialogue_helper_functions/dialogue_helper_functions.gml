dialogue_functions = {
	textevent_already_underway: function() {
		return instance_number(obj_textevent_vStruct) > 1 or
			instance_number(obj_textbox_vStruct) > 0;
	}
}