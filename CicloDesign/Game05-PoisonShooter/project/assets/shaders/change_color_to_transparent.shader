shader_type canvas_item;
render_mode unshaded;

uniform vec4 target_color : hint_color;

bool approx_eq(vec4 c1, vec4 c2) {
	return all(lessThan(abs(c1 - c2), vec4(0.001, 0.001, 0.001, 0.001)));
}

void fragment() {
	/*
	vec4 color = texture(TEXTURE,UV);
	if (approx_eq(color, target_color)) {
		color = vec4(1.0, 1.0, 1.0, 0.0);
	}
	COLOR = color;
	*/
}