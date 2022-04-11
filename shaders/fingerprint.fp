varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 scan_line;

void main()
{
    lowp vec4 tex = texture2D(texture_sampler, var_texcoord0.xy);
    tex.y = 1.0 - abs(scan_line.y - var_texcoord0.y) * 60.0;
    lowp float scan_mag = scan_line.y * scan_line.x + (1.0 - scan_line.x);
    lowp float print_colour = (scan_mag - var_texcoord0.y);
    tex.x = tex.x / print_colour;
    tex.z = tex.z * print_colour;
    gl_FragColor = tex;
}
