function draw_set_color_temp(color, action) {
	var originalColor = draw_get_color();
	draw_set_color(color);
	action();
	draw_set_color(originalColor);
}
