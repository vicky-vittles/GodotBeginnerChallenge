shader_type canvas_item;
render_mode unshaded;

const float THRESHOLD = 0.01;

uniform sampler2D destruction_map;
uniform float outline_width : hint_range(0.0, 8.0);
uniform vec4 outline_color : hint_color;

vec4 apply_destruction_map(sampler2D original_texture, vec2 uv)
{
	vec4 map_color = texture(destruction_map, uv);
	vec4 color = texture(original_texture, uv);
	color.a = map_color.a;
	return color;
}

void fragment() {
	// Apply destruction map to terrain
	vec4 color = apply_destruction_map(TEXTURE, UV);
	
	// Create outline
	vec2 size = vec2(outline_width) / vec2(textureSize(TEXTURE, 0));
    vec4 sprite_color = color;
    float alpha = sprite_color.a;
	alpha += apply_destruction_map(TEXTURE, UV + vec2(0.0, -size.y)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(size.x, -size.y)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(size.x, 0.0)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(size.x, size.y)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(0.0, size.y)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(-size.x, size.y)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(-size.x, 0.0)).a;
    alpha += apply_destruction_map(TEXTURE, UV + vec2(-size.x, -size.y)).a;
   
    vec3 final_color = mix(outline_color.rgb, sprite_color.rgb, sprite_color.a);
    COLOR = vec4(final_color, clamp(alpha, 0.0, 1.0));
}