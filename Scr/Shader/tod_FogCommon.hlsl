#ifndef TOD_SKY_FOG_COMMON
#define TOD_SKY_FOG_COMMON

// Distance
////////////
inline float TOD_FogDistance(float depth)
{
    float dist = depth * _ProjectionParams.z;
    return dist - _ProjectionParams.y;
}


/// Fog Factor
///////////////
// See: https://docs.microsoft.com/en-us/windows/desktop/direct3d9/fog-formulas
inline float TOD_FogExpFactor(float depth, float density)
{
    float dist = TOD_FogDistance(depth);
    return 1.0 - saturate(exp2(-density * dist));
}

inline float TOD_FogExp2Factor(float depth, float density)
{
    float re = TOD_FogDistance(depth);
    re       = density * re;
    return 1.0 - saturate(exp2(-re * re));
}

inline float TOD_FogLinearFactor(float viewDir, float2 startEnd)
{
    float dist = TOD_FogDistance(viewDir);
    dist       = (startEnd.y - dist) / (startEnd.y - startEnd.x);
    return 1.0 - saturate(dist);
}

#endif // TOD SKY FOG INCLUDED.
