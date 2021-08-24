shader_type canvas_item;
render_mode unshaded;

uniform bool flip;
uniform int u_bit_depth;
uniform float u_contrast;
uniform sampler2D color_palette;

void fragment(){ 
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV, 0.0);
	float lum = (col.r * 0.299) + (col.g * 0.587) + (col.b * 0.114);
	
	float contrast = u_contrast;
	lum = (lum - 0.5) * contrast + 0.5;
	lum = clamp(lum, 0.0, 1.0);
	
	float bits = float(u_bit_depth);
	lum = floor(lum * bits) / bits;
	
	col = texture(color_palette,vec2(abs(float(flip) - lum),0));
	COLOR = col;
}