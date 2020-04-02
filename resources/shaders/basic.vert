#version 450

layout (location = 0) in vec3 position;
layout (location = 1) in vec4 color;

layout (location = 0) uniform mat4 mvp;
out VS_OUTPUT {
    vec3 color;
} OUT;

void main() {
    gl_Position = mvp * vec4(position, 1.0);
    OUT.color = color.xyz;
}
