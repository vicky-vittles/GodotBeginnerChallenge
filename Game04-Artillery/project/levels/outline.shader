shader_type canvas_item;

const vec4 BLACK = vec4(0.0, 0.0, 0.0, 1.0);

uniform float outline_width : hint_range(0.0, 8.0);
uniform vec4 outline_color : hint_color;

void fragment() {
	// Create outline
	vec2 size = vec2(outline_width) / vec2(textureSize(TEXTURE, 0));
    vec4 sprite_color = texture(TEXTURE, UV);
    float alpha = sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
    alpha += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
    alpha += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    alpha += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
    alpha += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	
    vec3 final_color = mix(outline_color.rgb, sprite_color.rgb, sprite_color.a);
    vec4 color = vec4(final_color, clamp(alpha, 0.0, 1.0));
	
	vec4 diff = abs(BLACK-color);
	float d = max(max(diff.r, diff.g), diff.b);
	if (d < 0.1) {
		color.a = 0.0;
	}
	
	COLOR = color;
}