
#ifndef TOD_SKY_ATMOSPHERIC_SCATTERING_VARIABLES
#define TOD_SKY_ATMOSPHERIC_SCATTERING_VARIABLES

// General.
//////////////////
uniform half TOD_AtmosphereContrast;
uniform half4 TOD_GroundColor;

// Sun.
uniform half  TOD_SunBrightness;
uniform half4 TOD_SunAtmosphereTint;

// Moon.
uniform half  TOD_MoonContribution;
uniform half3 TOD_MoonAtmosphereTint;

// Mie.
//////////////////
// Sun
uniform float TOD_SunMieAnisotropy;
uniform half4 TOD_SunMieTint;
uniform half  TOD_SunMieScattering;

// Partial Mie Phase.
uniform float3 TOD_PartialSunMiePhase;

// Partial Mie Phase.
uniform float3 TOD_PartialMoonMiePhase;

// Moon
uniform float TOD_MoonMieAnisotropy;
uniform half4 TOD_MoonMieTint;
uniform half  TOD_MoonMieScattering;


// Post Proccesing.
////////////////////
uniform half TOD_SunMiePhaseDepthMultiplier;
uniform half TOD_MoonMiePhaseDepthMultiplier;
uniform half TOD_RayleighDepthMultiplier;

uniform float TOD_PPBlendTint;
uniform float TOD_PPSmoothTint;

#endif // TOD SKY  ATMOSPHERIC SCATTERING VARIABLES
