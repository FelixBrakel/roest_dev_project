#version 450

layout (location = 5) uniform vec4 matColor;

struct TestStruct {
	vec3 data;
	vec3 other_data;
};

uniform Defaults {
	mat4 mvp;
	mat4 mv;
	vec3 test_arr[2];
	TestStruct test_struct;
	TestStruct test_struct_arr[3];
} test;

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
