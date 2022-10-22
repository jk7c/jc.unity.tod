#ifndef TOD_SKY_PREEHTAM_HOFFMAN_ATMOSPHERIC_SCATTERING
#define TOD_SKY_PREEHTAM_HOFFMAN_ATMOSPHERIC_SCATTERING

#include "tod_ATMSVariables.hlsl"
#include "tod_ATMSCommon.hlsl"
//////////////////////////////////////////////////
/// Atmospheric Scattering based on 
/// Naty Hoffman and Arcot. J. Preetham papers.
//////////////////////////////////////////////////

// Params
////////////////////
uniform float TOD_AtmosphereHaziness;
uniform float TOD_AtmosphereZenithOffset;

uniform float TOD_RayleighZenithLength;
uniform float TOD_MieZenithLength;

uniform float3 TOD_BetaRay;
uniform float3 TOD_BetaMie;

uniform float TOD_SunsetDawnHorizon;
uniform half TOD_DayIntensity;
uniform half TOD_NightIntensity;

// Optical Depth
//////////////////
inline void CustomOpticalDepth(float pos, inout float2 srm)
{
    pos = saturate(pos * TOD_AtmosphereHaziness); 
    float zenith = acos(pos);
    zenith       = cos(zenith) + 0.15 * pow(93.885 - ((zenith * 180) / UNITY_PI), -1.253);
    zenith       = 1.0/(zenith + (TOD_AtmosphereZenithOffset * 0.5));

    srm.x = zenith * TOD_RayleighZenithLength;
    srm.y = zenith * TOD_MieZenithLength;
}

inline void OptimizedOpticalDepth(float pos, inout float2 srm)
{
    pos   = saturate(pos * TOD_AtmosphereHaziness);
    pos   = 1.0/(pos + TOD_AtmosphereZenithOffset);

    srm.x = pos * TOD_RayleighZenithLength;
    srm.y = pos * TOD_MieZenithLength;
}

// cOMBINED EXTINCTION FACTOR.
inline float3 TOD_ComputeCEF(float2 srm)
{
    return exp(-(TOD_BetaRay * srm.x + TOD_BetaMie * srm.y));
}

inline half3 TOD_ComputePHAtmosphericScattering(float3 inCef, float sunCosTheta, float3 sunMiePhase, float3 moonMiePhase, float depth)
{
    
    float3 cef = saturate(lerp(1.0-inCef, (1.0-inCef) * inCef, TOD_SunsetDawnHorizon));

    // Sun/Day calculations
    //////////////////////////
    float sunRayleighPhase = TOD_RayleighPhase(TOD_3PI16, sunCosTheta);
    float3 sunBRT          = TOD_BetaRay * sunRayleighPhase;

    // Multiply per zdepth
    #if defined(TOD_POST_PROCESSING)
    float depthmul = depth * TOD_RayleighDepthMultiplier;
    sunBRT *= depthmul;
    #endif

    float3 sunBMT  = TOD_BetaMie * sunMiePhase;
    float3 sunBRMT = (sunBRT + sunBMT) / (TOD_BetaRay + TOD_BetaMie);

    // Scattering result for sun light
    half3 sunScatter = TOD_DayIntensity * (sunBRMT*cef) * TOD_SunAtmosphereTint;
    sunScatter       = lerp(sunScatter * (1.0-inCef), sunScatter, TOD_SunAtmosphereTint.a);

    // Moon/Night calculations
    ///////////////////////////
    // Used simple calculations for more performance
    #if defined(TOD_ENABLE_MOON_RAYLEIGH)
        half3 moonScatter = TOD_NightIntensity.x * (1.0-inCef) * TOD_MoonAtmosphereTint;

        // Multiply per zdepth
        #if defined(TOD_POST_PROCESSING)
        moonScatter *= depthmul;
        #endif

        moonScatter += moonMiePhase; // Add moon mie phase
        return (sunScatter + moonScatter);
    #else
        return (sunScatter + moonMiePhase);
    #endif
}

inline half3 TOD_RenderPHATMS(float3 pos, out float3 sunMiePhase, out float3 moonMiePhase, float2 depth)
{
    half3 re = TOD_Zero3;
    half3 multParams = TOD_One3;

    // Get common multipliers
    #if defined(TOD_POST_PROCESSING)
    multParams.x = (depth.x * TOD_SunMiePhaseDepthMultiplier);
    multParams.y = (depth.x * TOD_MoonMiePhaseDepthMultiplier);
    #else
    multParams.z = 1.0 - TOD_GroundMask(pos.y); // Get upper sky mask
    #endif

    float2 cosTheta = float2(
        dot(pos.xyz, TOD_LocalSunDirection.xyz), // Sun
        dot(pos.xyz, TOD_LocalMoonDirection.xyz) // Moon
    );

    // Compute post processing y position
    #if defined(TOD_POST_PROCESSING)
    float3 p;
    p.x = saturate(depth.x + 1.0);
    p.y = saturate(depth.x - 1.0);
    p.z = smoothstep(p.x, p.y, TOD_PPBlendTint);
    pos.y   = lerp(pos.y, p.z, TOD_PPSmoothTint);
    #endif

    // Compute optical depth
    float2 srm;
    #if defined(SHADER_API_MOBILE)
    OptimizedOpticalDepth(pos.y, srm);
    #else
    CustomOpticalDepth(pos.y, srm);
    #endif

    // Get combined extinction factor
    float3 cef = TOD_ComputeCEF(srm);

    #if defined(TOD_ENABLE_MIE_PHASE)
    sunMiePhase   = TOD_PartialMiePhase(TOD_INVPI4, cosTheta.x, TOD_PartialSunMiePhase, TOD_SunMieScattering);
    sunMiePhase  *= multParams.x * TOD_SunMieTint.rgb * multParams.z;
    moonMiePhase  = TOD_PartialMiePhase(TOD_INVPI4, cosTheta.y, TOD_PartialMoonMiePhase, TOD_MoonMieScattering);
    moonMiePhase *= multParams.y * TOD_MoonMieTint.rgb * multParams.z;
    re.rgb = TOD_ComputePHAtmosphericScattering(cef, cosTheta.x, sunMiePhase, moonMiePhase, depth.y);
    #else
    sunMiePhase = TOD_Zero3;
    moonMiePhase = TOD_Zero3;
    re.rgb = TOD_ComputePHAtmosphericScattering(cef, cosTheta.x, sunMiePhase, moonMiePhase, depth.y);
    #endif

    TOD_ATMSColorCorrection(re.rgb, TOD_GroundColor.rgb, TOD_GlobalIntensity, TOD_AtmosphereContrast);
    //re = TOD_ATMSApplyGroundColor(pos.y, re);

    return re;
}

#endif // TOD SKY PREETHAM AND HOFFMAN ATMOSPHERIC SCATTERING INCLUDED.
