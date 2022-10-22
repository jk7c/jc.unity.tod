
using System;
using UnityEngine;
using TimeOfDay.Utility;

namespace TimeOfDay
{

    /// <summary> Atmospheric scattering wavelength. </summary>
    [Serializable] 
    public struct TOD_Wavelength
    {
        [Range(0,2000)] public float red, green, blue;

        public TOD_Wavelength(float _red, float _green, float _blue) 
        {
            this.red = _red; this.green = _green; this.blue = _blue;
        }

        // Wavelenght eart values.
        static readonly TOD_Wavelength earthWavelenghValues  = new TOD_Wavelength(650f, 570f, 475f);
        static readonly TOD_Wavelength earthWavelenghValues2 = new TOD_Wavelength(680f, 550f, 440f);
        static readonly TOD_Wavelength earthWavelenghValues3 = new TOD_Wavelength(650f, 550f, 475f);
       
        /// <summary> Defautl Wavelength Eart Values #1. </summary>
        public static TOD_Wavelength EarthValues => earthWavelenghValues;

        /// <summary> Defautl Wavelength Eart Values #2. </summary>
        public static TOD_Wavelength EarthValues2 => earthWavelenghValues2; 

        /// <summary> 
        /// Wavelength * 1e-9 
        /// Based on Preetham and H offman papers.
        /// </summary>
        public Vector3 Lambda
        {
            get
            {
                const float m = 1e-9f;
                Vector3 re;
                re.x = red   * m;
                re.y = green * m;
                re.z = blue  * m;
                return re; 
            }
        }
    }

    /// <summary> Mie Phase Values </summary>
    [Serializable] 
    public struct TOD_MiePhase
    {
        public Color tint;

        // g value.
        [Range(0, 0.999f)] public float anisotropy;

        public float scattering;

        public TOD_MiePhase(Color _tint, float _anisotropy, float _scattering)
        {
            this.tint       = _tint;
            this.anisotropy = _anisotropy;
            this.scattering = _scattering;
        }
        
        // Default values.
        static readonly TOD_MiePhase m_Defautl = new TOD_MiePhase(Color.white, 0.75f, 5.0f);

        /// <summary> Default values. </summary>
        public static TOD_MiePhase Default => m_Defautl;
    }

    [Serializable] 
    public class TOD_AtmosphericScatteringParams
    {
    #region [General Settings]

        public bool applyFastTonemap;

        [Range(0.0f, 1.0f)] public float contrast;

        public Color groundColor;

    #endregion

    #region [Rayleigh]

        public TOD_Wavelength wavelength;

        [Range(0.0f, 25f)] public float tickness;

        [Range(0.0f, 1.0f)] public float atmosphereHaziness;
        [Range(0.0f, 0.1f)] public float atmosphereZenithOffset;
        [Range(0.0f, 8.4e3f)] public float rayleighZenithLength;

        // Sun/Day.
        [Range(0.0f, 150f)] public float sunBrightness;    
        public Color sunAtmosphereTint;
        public Gradient sunAtmosphereGradient = new Gradient();

        // Moon/Night.
        [Range(0.0f, 1.0f)] public float moonContribution;
        public Color moonAtmosphereTint;

    #endregion

    #region [Mie]

        // General.
        [Range(0,0.5f)] public float mie;

        [Range(0.0f, 1.25e3f)] public float mieZenithLength;

        // Sun mie values.
        public TOD_MiePhase sunMie;

        // Moon mie values.
        public TOD_MiePhase moonMie;

    #endregion
    }
}