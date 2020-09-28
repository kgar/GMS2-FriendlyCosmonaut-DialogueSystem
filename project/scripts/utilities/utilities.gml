function draw_set_color_temp(color, action) {
	var originalColor = draw_get_color();
	draw_set_color(color);
	action();
	draw_set_color(originalColor);
}

function draw_set_font_temp(font, action) {
	var originalFont = draw_get_font();
	draw_set_font(font);
	action();
	draw_set_font(originalFont);
}

function array_insert_at(array, index, itemToInsert) {
	var length = array_length(array) + 1;
	var itemToShift = itemToInsert;
	for (var i = index; i < length; i++) {
		var currentItem = array[i];
		array[i] = itemToShift;
		itemToShift = currentItem;
	}
	
	return array;
}