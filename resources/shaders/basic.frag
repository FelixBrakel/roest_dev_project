#version 450

layout (location = 5) uniform vec4 matColor;

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
	vec3 position_worldspace;
	vec3 normal_cameraspace;
	vec3 eyedirection_cameraspace;
	vec3 lightdirection_cameraspace;
} IN;

out vec4 color;

void main() {
	vec3 lightColor = test.test_struct.data;
	float lightPower = 20.0f;

	float distance = length(vec3(0, 0, 0) - IN.position_worldspace);

	vec3 n = normalize(IN.normal_cameraspace);
	vec3 l = normalize(IN.lightdirection_cameraspace);

	float cosTheta = clamp(dot(n, l), 0, 1);

//	vec3 eye = normalize(IN.eyedirection_cameraspace);
//	vec3 reflection = reflect(-l, n);

//	float cosalpha = clamp(dot(eye, reflection), 0, 1);

	color = vec4(matColor.xyz * lightColor * lightPower * cosTheta / (distance * distance), 1);
}
