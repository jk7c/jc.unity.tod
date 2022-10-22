
using System;
using UnityEngine;
using TimeOfDay.Utility;

namespace TimeOfDay
{

    /// <summary></summary>
    [Serializable] 
    public class TOD_MoonParams
    {
        public Texture2D tex;
        public Vector2 texOffsets;
        public Color tint;
        public float intensity;
        [Range(0.0f, 1.0f)] public float contrast;
    }
    
    /// <summary></summary>
    [Serializable] 
    public class TOD_Moon
    {
        
        [SerializeField] private TOD_MoonParams m_Params = new TOD_MoonParams
        {
            tex        = null,
            texOffsets = Vector2.zero,
            tint       = Color.white,
            intensity  = 1.0f,
            contrast   = 0.3f
        };

        /// <summary></summary>
        public void SetParams(Material material)
        {
            material.SetTexture(TOD_PropertyIDs.m_TexID, m_Params.tex);
            material.SetTextureOffset(TOD_PropertyIDs.m_TexID, m_Params.texOffsets);
            material.SetColor(TOD_PropertyIDs.m_TintID, m_Params.tint);
            material.SetFloat(TOD_PropertyIDs.m_IntensityID, m_Params.intensity);
            material.SetFloat(TOD_PropertyIDs.m_ContrastID, m_Params.contrast);
        }
    }
    
}
