shader_type canvas_item;

//uniform float progress: hint_range (0.0, 1.0) = 0.0;
uniform vec3 outline_colour: source_color = vec3(1.0,0.0,0.0);

void fragment() {
	vec4 color_silouette = vec4(outline_colour, COLOR.a);
	COLOR = mix(COLOR, color_silouette, progress * (1.0 - COLOR.a));
}