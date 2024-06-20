shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 4;
uniform bool onoff = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (onoff){
		vec4 col = texture(TEXTURE, UV) * 0.16;
		col += texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.075;
		col += texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.075;
		col += texture(TEXTURE, UV + vec2(2.0 * TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.06;
		col += texture(TEXTURE, UV + vec2(2.0 * -TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.06;
		col += texture(TEXTURE, UV + vec2(3.0 * TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.045;
		col += texture(TEXTURE, UV + vec2(3.0 * -TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.045;
		col += texture(TEXTURE, UV + vec2(4.0 * TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.025;
		col += texture(TEXTURE, UV + vec2(4.0 * -TEXTURE_PIXEL_SIZE.x, 0.0)) * 0.025;
		col += texture(TEXTURE, UV + vec2(0.0, TEXTURE_PIXEL_SIZE.y)) * 0.075;
		col += texture(TEXTURE, UV + vec2(0.0, -TEXTURE_PIXEL_SIZE.y)) * 0.075;
		col += texture(TEXTURE, UV + vec2(0.0, 2.0 * TEXTURE_PIXEL_SIZE.y)) * 0.06;
		col += texture(TEXTURE, UV + vec2(0.0, 2.0 * -TEXTURE_PIXEL_SIZE.y)) * 0.06;
		col += texture(TEXTURE, UV + vec2(0.0, 3.0 * TEXTURE_PIXEL_SIZE.y)) * 0.045;
		col += texture(TEXTURE, UV + vec2(0.0, 3.0 * -TEXTURE_PIXEL_SIZE.y)) * 0.045;
		col += texture(TEXTURE, UV + vec2(0.0, 4.0 * TEXTURE_PIXEL_SIZE.y)) * 0.025;
		col += texture(TEXTURE, UV + vec2(0.0, 4.0 * -TEXTURE_PIXEL_SIZE.y)) * 0.025;
		COLOR = col - vec4(0.1,0.1,0.1,0);
	}
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
