varying highp vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform highp vec4 cover;

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    float decider = (var_texcoord0.x + var_texcoord0.y * 7723.0) - floor(var_texcoord0.x + var_texcoord0.y * 7723.0);
    float factor = 7979.0 * decider;
    //if(decider > 0.5) {factor = 69.0;}
    float num = var_texcoord0.x * var_texcoord0.y * factor - floor(var_texcoord0.x * var_texcoord0.y * factor);
    if(num > cover.x)
    {
        discard;
    }
    gl_FragColor = texture2D(texture_sampler, var_texcoord0.xy) * tint_pm;
}
