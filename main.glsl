#ifdef GL_ES
precision mediump float;
#endif

#extension GL_OES_standard_derivatives : enable

uniform float time;
uniform vec2 resolution;

float culc_julia(vec2 pos, vec2 c)
{
    int result = 0;
    vec2 an = pos;
    const int max_iterate = 30;
    for(int i = 0; i < max_iterate; ++i)
    {
        an = vec2(an.x * an.x - an.y * an.y, 2.0 * an.x * an.y) + c;
        result = i;
        if(length(an) > 4.0) break;
    }
    return float(result) / float(max_iterate);
}

void main(void)
{
    vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
    vec3 color_vec = vec3(sin(time * 0.5) * 0.25 + 0.5, sin(time * 0.5 + 3.1415) * 0.25 + 0.5, sin(time * 0.7) * 0.25 + 0.5);
    gl_FragColor = vec4(color_vec * culc_julia(uv * 1.0, vec2(cos(time * 0.5), sin(time * 0.5))), 1.0);
}