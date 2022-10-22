#ifndef TOD_SKY_ATMOSPHERIC_SCATTERING_COMMON
#define TOD_SKY_ATMOSPHERIC_SCATTERING_COMMON
////////////////////////////////////////////////
/// For Preetham model and Eric Brunetton model
/// Mie phase "m" param is 1.0/(PI*4)
/// Rayleigh  "m" param is 3/(PI*16)
////////////////////////////////////////////////

// Rayleigh Phase
////////////////////
inline float TOD_RayleighPhase(float m, float cosTheta)
{
    return m * (1.0 + cosTheta * cosTheta);
}

// Mie Phase
///////////////////
inline float3 TOD_PartialMiePhase(float g)
{
    float g2 = g*g;
    return float3((1.0 - g2) / (2.0 + g2), 1.0 + g2, 2.0 * g);
}

inline float TOD_MiePhase(float m, float cosTheta, float g, half scattering)
{
    float3 PHG = TOD_PartialMiePhase(g);
    return (m * PHG.x * ((1.0 + cosTheta * cosTheta) * pow(PHG.y - (PHG.z * cosTheta), -1.5))) * scattering;
}

inline float TOD_PartialMiePhase(float m, float cosTheta, float3 partialMiePhase, half scattering)
{
    return
    (
        m * partialMiePhase.x * ((1.0 + cosTheta * cosTheta) *
        pow(partialMiePhase.y - (partialMiePhase.z * cosTheta), -1.5))
    ) * scattering;
}

// Color Correction
/////////////////////
inline void TOD_ATMSColorCorrection(inout half3 col, half exposure, half contrast)
{
    #if defined(TOD_ATMS_APPLY_FAST_TONEMAP)
    col.rgb = TOD_FastTonemap(col.rgb, exposure);
    #else
    col.rgb *= exposure;
    #endif

    col.rgb = TOD_Pow3(col.rgb, contrast);
    #if defined(UNITY_COLORSPACE_GAMMA)
    col.rgb = TOD_LINEAR_TO_GAMMA(col.rgb);
    #endif
}

inline void TOD_ATMSColorCorrection(inout half3 col, half3 groundCol, half exposure, half contrast)
{
    TOD_ATMSColorCorrection(col.rgb, exposure, contrast);
    groundCol.rgb *= groundCol.rgb;
}

// Ground
////////////////////
inline half TOD_GroundMask(float pos)
{
    return saturate(-pos*100);
}

inline half3 TOD_ATMSApplyGroundColor(float pos, half3 skyCol)
{
    fixed mask = TOD_GroundMask(pos);
    return lerp(skyCol.rgb, TOD_GroundColor * skyCol.rgb, mask);
}

#endif // TOD ATMOSPHERIC SCATTERING COMMON INCLUDED.