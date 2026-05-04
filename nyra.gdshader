shader_type spatial;

uniform vec4 emission_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform float emission_energy : hint_range(0.0, 10.0) = 3.0;
uniform float ripple_speed : hint_range(0.0, 10.0) = 2.0;
uniform float ripple_strength : hint_range(0.0, 0.2) = 0.05;

void vertex() {
	float wave = sin(VERTEX.y * 8.0 + TIME * ripple_speed) * ripple_strength;
	wave += sin(VERTEX.x * 6.0 + TIME * ripple_speed * 1.3) * ripple_strength * 0.5;
	VERTEX += NORMAL * wave;
}

void fragment() {
	float fresnel = pow(1.0 - abs(dot(NORMAL, VIEW)), 3.0);
	ALBEDO = emission_color.rgb * 0.3;
	EMISSION = emission_color.rgb * emission_energy * (1.0 + fresnel * 3.0);
	ROUGHNESS = 0.1;
	SPECULAR = 1.0;
}
