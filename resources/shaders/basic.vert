#version 450

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;

layout (location = 0) uniform mat4 mvp;
layout (location = 1) uniform mat4 mv;
layout (location = 2) uniform mat4 m;
layout (location = 3) uniform mat4 v;
layout (location = 4) uniform mat4 p;

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

//layout (location = 5) light vec4 color;
out VS_OUTPUT {
    vec3 position_worldspace;
    vec3 normal_cameraspace;
    vec3 eyedirection_cameraspace;
    vec3 lightdirection_cameraspace;
} OUT;

void main() {
    gl_Position = test.mvp * vec4(position, 1.0);

    OUT.position_worldspace = (m * vec4(position, 1.0)).xyz;

    vec3 position_cameraspace = (mv * vec4(position, 1.0)).xyz;

    vec3 eyedirection_cameraspace = vec3(0, 0, 0) - position_cameraspace;
    OUT.eyedirection_cameraspace = eyedirection_cameraspace;

    vec3 lightposition_cameraspace = (v * vec4(0, 0, 0, 1.0)).xyz;
    OUT.lightdirection_cameraspace = lightposition_cameraspace + eyedirection_cameraspace;

    OUT.normal_cameraspace = (mv * vec4(normal, 0)).xyz;
}
