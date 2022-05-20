varying mediump vec2 var_texcoord0;

uniform mediump sampler2D texture_sampler;
uniform mediump vec4 scan_line;

void main()
{
    mediump vec4 tex = texture2D(texture_sampler, var_texcoord0.xy);
    tex.y = 1.0 - abs(scan_line.y - var_texcoord0.y) * 60.0;
    mediump float scan_mag = scan_line.y * scan_line.x + (1.0 - scan_line.x);
    mediump float print_colour = (scan_mag - var_texcoord0.y);
    tex.x = tex.x / (print_colour * 4.0);
    tex.z = tex.z * print_colour;
    gl_FragColor = tex;
}
