
using System;
using UnityEngine;
using TimeOfDay.Utility;

namespace TimeOfDay
{

    [Serializable] public class TOD_SunParams
    {
        public Texture2D tex;

        [ColorUsage(false, true)] public Color tint;
        public float intensity;
    }

    [Serializable] public class TOD_Sun
    {

        [SerializeField] private TOD_SunParams m_Params = new TOD_SunParams
        {
            tex       = null,
            tint      = Color.white,
            intensity = 1.0f
        };

        /// <summary></summary>
        public void SetParams(Material material)
        {
            material.SetTexture(TOD_PropertyIDs.s_TexID, m_Params.tex);
            material.SetColor(TOD_PropertyIDs.s_TintID, m_Params.tint);
            material.SetFloat(TOD_PropertyIDs.s_IntensityID, m_Params.intensity);
        }
    }

}