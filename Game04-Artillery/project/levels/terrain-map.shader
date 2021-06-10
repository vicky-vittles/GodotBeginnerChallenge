shader_type canvas_item;

const float THRESHOLD = 0.01;

uniform sampler2D destruction_map;

void fragment() {
	vec4 map_color = texture(destruction_map, UV);
	vec4 color = texture(TEXTURE, UV);
	color.a = map_color.a;
	COLOR = color;
}