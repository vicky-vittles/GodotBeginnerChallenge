shader_type canvas_item;

const vec4 WHITE_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 TRANSPARENT = vec4(1.0, 1.0, 1.0, 0.0);
const float THRESHOLD = 0.01;

uniform sampler2D destruction_map;

void fragment() {
	vec4 terrain_color = texture(TEXTURE, UV);
	vec4 map_color = texture(destruction_map, UV);
	vec4 d4 = abs(map_color - WHITE_COLOR);
	float d = max(max(d4.r, d4.g), d4.b);
	
	if (d < THRESHOLD) {
		COLOR = TRANSPARENT;
	} else {
		COLOR = terrain_color;
	}
}