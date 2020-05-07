#version 450

uniform Material {
	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
	float shininess;
} material;

struct PointLight {
	vec3 position;

	float constant;
	float linear;
	float quadratic;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

struct DirectionalLight {
	vec3 direction;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

struct SpotLight {
	vec3 position;
	vec3 direction;

	float inner_cone;
	float outer_cone;

	float constant;
	float linear;
	float quadratic;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};

uniform Lights {
	DirectionalLight directional;
	PointLight[16] point_lights;
	SpotLight[16] spot_lights;

	int num_point_lights;
	int num_spot_lights;
} lights;

in VS_OUTPUT {
	vec3 position_viewspace;
	vec3 normal_viewspace;
} IN;

out vec4 color;

vec3 calc_point_light(PointLight light, vec3 normal, vec3 position, vec3 view_dir) {
	vec3 ambient = light.ambient * material.ambient;

	vec3 light_dir = normalize(light.position - position);
	float theta_diff = max(dot(normal, light_dir), 0.0);
	vec3 diffuse = light.diffuse * (theta_diff * material.diffuse);

	vec3 reflect_dir = reflect(-light_dir, normal);
	float theta_spec = pow(max(dot(view_dir, reflect_dir), 0.0), material.shininess);
	vec3 specular = light.specular * (theta_spec * material.specular);

	float distance = length(light.position - position);
	float attenuation = 1.0 / (light.constant +
						light.linear * distance +
						light.quadratic * (distance * distance));

	return (ambient * attenuation) + (diffuse * attenuation) + (specular * attenuation);
}

void main() {
	vec3 result = vec3(0.0, 0.0, 0.0);
	vec3 view_dir = normalize(-IN.position_viewspace);
	for (int i = 0; i < lights.num_point_lights; ++i) {
		result += calc_point_light(lights.point_lights[i], IN.normal_viewspace, IN.position_viewspace, view_dir);
	}

	color = vec4(result, 1.0);
}
