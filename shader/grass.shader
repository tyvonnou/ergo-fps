shader_type spatial;

render_mode blend_mix,depth_draw_opaque,cull_disabled,diffuse_burley,specular_schlick_ggx;

uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float alpha_scissor_threshold;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform sampler2D texture_normal : hint_normal;
uniform float normal_scale : hint_range(-16,16);
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform vec2 amplification = vec2(50.0, 50.0);

void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
	VERTEX.x += cos(TIME) * sin(VERTEX.y) * amplification.x;
	VERTEX.z += cos(TIME) * sin(VERTEX.y) * amplification.y;
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
	NORMALMAP = texture(texture_normal,base_uv).rgb;
	NORMALMAP_DEPTH = normal_scale;
	ALPHA = albedo.a * albedo_tex.a;
	ALPHA_SCISSOR=alpha_scissor_threshold;
}
