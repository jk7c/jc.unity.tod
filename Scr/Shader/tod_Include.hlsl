#ifndef TOD_SKY_INCLUDE
#define TOD_SKY_INCLUDE

/// PI
////////////////////
#define TOD_PI4     12.56637061f  // PI*4
#define TOD_INVPI4  0.079577472f  // 1/(PI*4)
#define TOD_3PIE    0.119366207f  // 3/(PI*8)
#define TOD_3PI16   0.059683104f  // 3/(PI*16)

static const fixed  TOD_Zero  = 0.0;
static const fixed  TOD_One   = 1.0;
static const fixed  TOD_Zero2 = fixed2(0.0, 0.0);
static const fixed  TOD_One2  = fixed2(1.0, 1.0);
static const fixed  TOD_Zero3 = fixed3(0.0, 0.0, 0.0);
static const fixed3 TOD_One3  = fixed3(1.0, 1.0, 1.0);

// Horizon Fade
///////////////////
#define TOD_HORIZON_FADE(vertex) saturate(2.0 * normalize(mul((float3x3)unity_ObjectToWorld, vertex.xyz)).y)
#define TOD_WORLD_HORIZON_FADE(pos) saturate(normalize(pos).y)

// Transform
///////////////////
//CBUFFER_START(TODMatrices)
// 4x4 Matrices.
uniform float4x4 TOD_WorldToObject;
uniform float4x4 TOD_ObjectToWorld;
//CBUFFER_END

//CBUFFER_START(TODCelestialDirections)
// Celestials Directions.
uniform float3 TOD_LocalSunDirection;
uniform float3 TOD_WorldSunDirection;
uniform float3 TOD_LocalMoonDirection;
uniform float3 TOD_WorldMoonDirection;
//CBUFFER_END

#define TOD_WORLD_POS(vertex) mul(TOD_WorldToObject, mul(unity_ObjectToWorld, vertex)).xyz;

// Custom clip pos. 
inline float4 TOD_DomeToClipPos(in float3 position)
{
    float4 pos = UnityObjectToClipPos(position);
    #ifdef UNITY_REVERSED_Z
        pos.z = 1e-5f;
    #else
        pos.z = pos.w - 1e-5f;
    #endif

    return pos;
}

// Color
//////////////////
uniform half TOD_GlobalIntensity;

// Color Space Support
#ifdef SHADER_API_MOBILE
    #define TOD_LINEAR_TO_GAMMA(color) sqrt(color)
#else  
    #define TOD_LINEAR_TO_GAMMA(color) pow(color, 0.45454545f)
#endif

// Simple and fast tonemaping. 
inline half TOD_FastTonemap(half c, half exposure)
{
    return 1.0 - exp(exposure * -c);
}
inline half2 TOD_FastTonemap(half2 c, half exposure)
{
    return 1.0 - exp(exposure * -c.rg);
}
inline half3 TOD_FastTonemap(half3 c, half exposure)
{
    return 1.0 - exp(exposure * -c.rgb);
}
inline half4 TOD_FastTonemap(half4 c, half exposure)
{
    return  half4(TOD_FastTonemap(c.rgb, exposure), c.a);
}

// Only Test
inline half3 TOD_ACESL(half3 col)
{
    const float a = 2.51;
    const float b = 0.03;
    const float c = 2.43;
    const float d = 0.59;
    const float e = 0.14;
    return (col * (a * col + b)) / (col * (c * col + d) + e);
}

// Grayscale
inline half3 ToGrayscale(half3 c)
{
    return (c.r + c.g + c.b) * 0.333333f;
}

// Exponent
inline half TOD_Pow2(half x, half fade)
{
    return lerp(x, x*x, fade);
}

inline half3 TOD_Pow2(half3 x, half fade)
{
    return lerp(x, x*x, fade);
}

inline half TOD_Pow2(half x)
{
    return x*x;
}

inline half3 TOD_Pow2(half3 x)
{
    return x*x;
}

inline half TOD_Pow3(half x, half fade)
{
    return lerp(x, x*x*x, fade);
}

inline half3 TOD_Pow3(half3 x, half fade)
{
    return lerp(x, x*x*x, fade);
}

inline half TOD_Pow3(half x)
{
    return x*x*x;
}

inline half3 TOD_Pow3(half3 x)
{
    return x*x*x;
}

#endif // TOD SKY INCLUDED.
