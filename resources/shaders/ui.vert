#version 450
layout (location = 0) in vec2 position;
layout (location = 2) in vec2 uv;
layout (location = 1) in vec4 col;

out VS_OUTPUT {
    vec2 uv;
    vec4 col;
} OUT;

void main() {
    OUT.uv = uv;
    OUT.col = col;
    gl_Position = vec3(position, 1.0);
}
