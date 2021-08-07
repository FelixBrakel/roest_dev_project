#version 450
#extension GL_ARB_bindless_texture : enable
uniform Material {
    sampler2D texture;
} material;

in VS_OUTPUT {
    vec2 uv;
    vec4 col;
} IN;

void main() {
    gl_FragColor = texture(material.texture, IN.uv) * IN.col;
}
