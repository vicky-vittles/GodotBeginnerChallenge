shader_type canvas_item;
render_mode unshaded;

const float THRESHOLD = 0.01;

uniform sampler2D destruction_map;

vec4 apply_destruction_map(sampler2D original_texture, vec2 uv)
{
	vec4 map_color = texture(destruction_map, uv);
	vec4 color = texture(original_texture, uv);
	color.a = map_color.a;
	return color;
}

void fragment() {
	vec4 color = apply_destruction_map(TEXTURE, UV);
	COLOR = color;
}