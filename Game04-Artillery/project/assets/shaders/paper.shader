shader_type canvas_item;

uniform sampler2D paperTexture;
uniform vec4 paperColor : hint_color;
uniform bool paperEffect = true;

uniform vec2 shadowOffset = vec2(8.0, 8.0);
uniform vec4 shadowColor : hint_color;
uniform bool shadowEffect = true;

void fragment() {
	// Init
	vec4 finalColor = texture(TEXTURE, UV);
	
	// Drop shadow effect
	if (shadowEffect) {
		vec2 ps = TEXTURE_PIXEL_SIZE;
	
		vec4 shadow = vec4(shadowColor.rgb, texture(TEXTURE, UV - shadowOffset * ps).a * shadowColor.a);
		vec4 col = texture(TEXTURE, UV);

		finalColor = mix(shadow, col, col.a);
	}
	
	// Paper background effect
	if (paperEffect) {
		vec4 diff = paperColor-finalColor;
		float d = max(max(diff.r, diff.g), diff.b);
	
		if (d < 0.1) {
			finalColor.rgb = texture(paperTexture, UV).rgb;
		}
	}
	
	COLOR = finalColor;
}