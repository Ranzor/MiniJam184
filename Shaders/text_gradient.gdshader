shader_type canvas_item;
render_mode unshaded; 

uniform sampler2D gradient :source_color;
uniform float gradient_mix_amount = 1.0;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
	float cosa = cos(rotation);
	float sina = sin(rotation);
	uv -= pivot;
	return vec2 (cosa * uv.x - sina * uv.y,
				 cosa * uv.y + sina * uv.x) + pivot;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 myUV = rotateUV(UV,vec2(0.5,0.5), radians(90));
	vec3 gradientTex = texture(gradient, UV).rgb;
	
	float greyscale_value = dot(gradientTex.rgb, vec3(0.299, 0.587, 0.114));
	
	vec3 sampled_color = texture(gradient, vec2(greyscale_value, 0.0)).rgb;
	
	COLOR.rgb = mix(gradientTex.rgb, sampled_color, gradient_mix_amount);
	vec4 pixelColor = texture(TEXTURE,UV);
	COLOR.a = pixelColor.a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
