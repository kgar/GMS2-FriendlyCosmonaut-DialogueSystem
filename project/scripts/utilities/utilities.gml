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