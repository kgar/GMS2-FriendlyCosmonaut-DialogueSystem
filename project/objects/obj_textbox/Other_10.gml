var scriptComponents = executeScript[page];
if(is_array(scriptComponents)){
	var argsLength = array_length_1d(scriptComponents)-1;
	var args = array_create(argsLength, 0);
	array_copy(args, 0, scriptComponents, 1, argsLength);
	var functionId = scriptComponents[0];
	script_execute_alt(functionId, args);
}