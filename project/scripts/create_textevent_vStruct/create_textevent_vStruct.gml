///@description create_textevent_vStruct
///@arg dialogue
function create_textevent_vStruct(_dialogue) {

	if(instance_exists(obj_textevent_vStruct)){ exit; }

	var textevent = instance_create_layer(0,0,"Instances",obj_textevent_vStruct);
	textevent.Init(_dialogue);
	return textevent;
}