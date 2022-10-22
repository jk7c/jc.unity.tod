#ifndef TOD_SKY_CLOUDS_INCLUDE
#define TOD_SKY_CLOUDS_INCLUDE

uniform sampler2D TOD_CloudsTex;
float4 TOD_CloudsTex_ST;

uniform half TOD_CloudsDensity;
uniform half TOD_CloudsCoverage;
uniform half TOD_CloudsSpeed, TOD_CloudsSpeed2;

fixed2 GetNoise(float2 coords)
{
    fixed2 n;
    n.x = tex2D(TOD_CloudsTex, coords.xy + _Time.x * TOD_CloudsSpeed).r;
    n.y = tex2D(TOD_CloudsTex, coords.yx + _Time.x * TOD_CloudsSpeed2).b;
    
    fixed re = ((n.x + n.y) * 0.5) - TOD_CloudsCoverage;
    return fixed2(re, re * TOD_CloudsDensity);
}


#endif // TOD SKY CLOUDS INCLUDED.
