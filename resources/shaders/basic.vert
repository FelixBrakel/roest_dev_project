#version 450
#extension GL_ARB_bindless_texture : enable
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 uv;

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

uniform Matrices {
    mat4 mvp;
    mat4 mv;
    mat4 m;
    mat4 v;
    mat4 p;
    mat3 n;
} matrices;

out VS_OUTPUT {
    vec3 position_viewspace;
    vec3 normal_viewspace;
    vec2 uv;
} OUT;

void main() {
    OUT.uv = uv;
    OUT.position_viewspace = (matrices.mv * vec4(position, 1.0)).xyz;
    OUT.normal_viewspace = matrices.n * normal;

//    gl_Position = vec4(position, 1.0);
    gl_Position = matrices.mvp * vec4(position, 1.0);
}
