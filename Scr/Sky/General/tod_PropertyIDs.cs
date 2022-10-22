using System;
using UnityEngine;

namespace TimeOfDay
{

    static class TOD_PropertyIDs
    {
    #region [General]

        // Color.
        internal static readonly int g_ExposureID      = Shader.PropertyToID("TOD_GlobalIntensity");
        internal static readonly int g_atmosphereTexID = Shader.PropertyToID("TOD_AtmosphereTex");

        // Position.
        internal static readonly int g_WorldSunDirectionID  = Shader.PropertyToID("TOD_WorldSunDirection");
        internal static readonly int g_WorldMoonDirectionID = Shader.PropertyToID("TOD_WorldMoonDirection");
        internal static readonly int g_LocalSunDirectionID  = Shader.PropertyToID("TOD_LocalSunDirection");
        internal static readonly int g_LocalMoonDirectionID = Shader.PropertyToID("TOD_LocalMoonDirection");
        internal static readonly int g_ObjectToWorldID      = Shader.PropertyToID("TOD_ObjectToWorld");
        internal static readonly int g_WorldToObjectID      = Shader.PropertyToID("TOD_WorldToObject");

    #endregion

    #region [Atmospheric Scattering]

        // General.
        //////////////
        internal static readonly int atms_ContrastID    = Shader.PropertyToID("TOD_AtmosphereContrast");
        internal static readonly int atms_GroundColorID = Shader.PropertyToID("TOD_GroundColor");

        // Rayleigh.
        /////////////
        // Wavelength.
        internal static readonly int atms_WavelengthRID = Shader.PropertyToID("TOD_WavelengthR");
        internal static readonly int atms_WavelengthGID = Shader.PropertyToID("TOD_WavelengthG");
        internal static readonly int atms_WavelengthBID = Shader.PropertyToID("TOD_WavelengthB");

        // Zenith and tickness.
        internal static readonly int atms_Tickness                 = Shader.PropertyToID("TOD_Tickness");
        internal static readonly int atms_AtmosphereHazinessID     = Shader.PropertyToID("TOD_AtmosphereHaziness");
        internal static readonly int atms_AtmosphereZenithOffsetID = Shader.PropertyToID("TOD_AtmosphereZenithOffset");
        internal static readonly int atms_RayleighZenithLengthID   = Shader.PropertyToID("TOD_RayleighZenithLength");

        // Color.
        internal static readonly int atms_BetaRayID           = Shader.PropertyToID("TOD_BetaRay");
        internal static readonly int atms_SunsetDawnHorizonID = Shader.PropertyToID("TOD_SunsetDawnHorizon");

        // Sun.
        internal static readonly int atms_SunBrightnessID      = Shader.PropertyToID("TOD_SunBrightness");
        internal static readonly int atms_SunAtmosphereTintID  = Shader.PropertyToID("TOD_SunAtmosphereTint");
        internal static readonly int atms_DayIntensityID       = Shader.PropertyToID("TOD_DayIntensity");

        // Moon.
        internal static readonly int atms_MoonContributionID   = Shader.PropertyToID("TOD_MoonContribution");
        internal static readonly int atms_MoonAtmosphereTintID = Shader.PropertyToID("TOD_MoonAtmosphereTint");
        internal static readonly int atms_NightIntensityID     = Shader.PropertyToID("TOD_NightIntensity");
        internal static readonly int atms_MoonRayleighModeID   = Shader.PropertyToID("TOD_MoonRayleighMode");

        // Mie.
        /////////////
        // General.
        internal static readonly int atms_MieID             = Shader.PropertyToID("TOD_Mie");
        internal static readonly int atms_MieZenithLengthID = Shader.PropertyToID("TOD_MieZenithLength");
        internal static readonly int atms_BetaMieID         = Shader.PropertyToID("TOD_BetaMie");

        // Sun.
        internal static readonly int atms_SunMieTintID         = Shader.PropertyToID("TOD_SunMieTint");
        internal static readonly int atms_SunMieAnisotropyID   = Shader.PropertyToID("TOD_SunMieAnisotropy");
        internal static readonly int atms_SunMieScatteringID   = Shader.PropertyToID("TOD_SunMieScattering");
        internal static readonly int atms_PartialSunMiePhaseID = Shader.PropertyToID("TOD_PartialSunMiePhase");

        // Moon.
        internal static readonly int atms_MoonMieTintID         = Shader.PropertyToID("TOD_MoonMieTint");
        internal static readonly int atms_MoonMieAnisotropyID   = Shader.PropertyToID("TOD_MoonMieAnisotropy");
        internal static readonly int atms_MoonMieScatteringID   = Shader.PropertyToID("TOD_MoonMieScattering");
        internal static readonly int atms_PartialMoonMiePhaseID = Shader.PropertyToID("TOD_PartialMoonMiePhase"); 

    #endregion
    
    #region [Deep Space]

        // Galaxu background.
        internal static readonly int gb_CubemapID   = Shader.PropertyToID("TOD_GalaxyBackgroundCubemap");
        internal static readonly int gb_TintID      = Shader.PropertyToID("TOD_GalaxyBackgroundTint");
        internal static readonly int gb_IntensityID = Shader.PropertyToID("TOD_GalaxyBackgroundIntensity");
        internal static readonly int gb_ContrastID  = Shader.PropertyToID("TOD_GalaxyBackgroundContrast");
        
        // Stars Field.
        internal static readonly int sf_CubemapID            = Shader.PropertyToID("TOD_StarsFieldCubemap");
        internal static readonly int sf_NoiseCubemapID       = Shader.PropertyToID("TOD_StarsFieldNoiseCubemap");
        internal static readonly int sf_TintID               = Shader.PropertyToID("TOD_StarsFieldTint");
        internal static readonly int sf_IntensityID          = Shader.PropertyToID("TOD_StarsFieldIntensity");
        internal static readonly int sf_NoiseMatrixID        = Shader.PropertyToID("TOD_StarsFieldNoiseMatrix");
        internal static readonly int sf_ScintillationID      = Shader.PropertyToID("TOD_StarsFieldScintillation");
        internal static readonly int sf_ScintillationSpeedID = Shader.PropertyToID("TOD_StarsFieldScintillationSpeed");

    #endregion

    #region [Near Space]

        // Sun.
        internal static readonly int s_TexID       = Shader.PropertyToID("TOD_SunTex");
        internal static readonly int s_TintID      = Shader.PropertyToID("TOD_SunTint");
        internal static readonly int s_IntensityID = Shader.PropertyToID("TOD_SunIntensity");

        // Moon.
        internal static readonly int m_TexID       = Shader.PropertyToID("TOD_MoonTex");
        internal static readonly int m_TintID      = Shader.PropertyToID("TOD_MoonTint");
        internal static readonly int m_IntensityID = Shader.PropertyToID("TOD_MoonIntensity");
        internal static readonly int m_ContrastID  = Shader.PropertyToID("TOD_MoonContrast");

    #endregion

    #region [Clouds]

        internal static readonly int c_TexID       = Shader.PropertyToID("TOD_CloudsTex");
        internal static readonly int c_TintID      = Shader.PropertyToID("TOD_CloudsTint");
        internal static readonly int c_IntensityID = Shader.PropertyToID("TOD_CloudsIntensity");
        internal static readonly int c_DensityID   = Shader.PropertyToID("TOD_CloudsDensity");
        internal static readonly int c_CoverageID  = Shader.PropertyToID("TOD_CloudsCoverage");
        internal static readonly int c_SpeedID     = Shader.PropertyToID("TOD_CloudsSpeed");
        internal static readonly int c_Speed2ID    = Shader.PropertyToID("TOD_CloudsSpeed2"); 

    #endregion

    #region [Ṕost Processing]

        // Fog.
        /////////
        internal static readonly int f_DensityID       = Shader.PropertyToID("TOD_FogDensity");
        internal static readonly int f_StartDistanceID = Shader.PropertyToID("TOD_FogStartDistance");
        internal static readonly int f_EndDistanceID   = Shader.PropertyToID("TOD_FogEndDistance");

        // Scattering.
        ///////////////
        internal static readonly int f_RayleighDepthMultID    = Shader.PropertyToID("TOD_RayleighDepthMultiplier");
        internal static readonly int f_SunMiePhaseDepthMultID = Shader.PropertyToID("TOD_SunMiePhaseDepthMultiplier");
        internal static readonly int f_MoonMiePhaseDepthMultID = Shader.PropertyToID("TOD_MoonMiePhaseDepthMultiplier");

        internal static readonly int f_SmoothTintID = Shader.PropertyToID("TOD_PPSmoothTint");
        internal static readonly int f_BlendTintID  = Shader.PropertyToID("TOD_PPBlendTint");


    #endregion
    
    }
}