﻿using System;
using UnityEngine;
using TimeOfDay;
using TimeOfDay.Utility;

namespace TimeOfDay.Legacy
{
    [ExecuteInEditMode, ImageEffectAllowedInSceneView]
    public class TOD_DistanceFogPFX : TOD_PostProcessingBase
    {

       [SerializeField] private TOD_FogParams m_FogParams = new TOD_FogParams
       {
           fogMode                     = FogMode.Exponential,
           density                     = 0.001f,
           startDistance               = 0.0f, 
           endDistance                 = 2000f,
           rayleighDepthMultiplier     = 0.75f,
           sunMiePhaseDepthMultiplier  = 1,
           moonMieṔhaseDepthMultiplier = 1,
           smoothTint                  = 1.0f,
           blendTint                   = 0.8f
       };

        // Property IDs.
        internal readonly int m_FrustumCornersID = Shader.PropertyToID("TOD_FrustumCorners");
        internal readonly int m_CameraPositionID = Shader.PropertyToID("TOD_CameraPosition");
       
        protected override void Start()
        {
            base.Start();
            m_Camera.depthTextureMode |= DepthTextureMode.Depth;
        }

        [ImageEffectOpaque]
        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
          
            if(!m_IsReady)
            {
                Graphics.Blit(source, destination);
                enabled = false;
                return;
            }

            FXMaterial.SetMatrix(m_FrustumCornersID, FrustumCorners());
            FXMaterial.SetVector(m_CameraPositionID, m_CameraTransform.position);

            FXMaterial.SetFloat(TOD_PropertyIDs.f_SunMiePhaseDepthMultID ,m_FogParams.sunMiePhaseDepthMultiplier);
            FXMaterial.SetFloat(TOD_PropertyIDs.f_MoonMiePhaseDepthMultID ,m_FogParams.moonMieṔhaseDepthMultiplier);

            FXMaterial.SetFloat(TOD_PropertyIDs.f_RayleighDepthMultID, m_FogParams.rayleighDepthMultiplier);
            FXMaterial.SetFloat(TOD_PropertyIDs.f_BlendTintID, m_FogParams.blendTint);
            FXMaterial.SetFloat(TOD_PropertyIDs.f_SmoothTintID, m_FogParams.smoothTint);


            int pass = 0;

            switch(m_FogParams.fogMode)
            {
                case FogMode.Linear:

                    pass = 0;
                    FXMaterial.SetFloat(TOD_PropertyIDs.f_StartDistanceID, m_FogParams.startDistance); 
                    FXMaterial.SetFloat(TOD_PropertyIDs.f_EndDistanceID, m_FogParams.endDistance);

                break;

                case FogMode.Exponential:

                    pass = 1;
                    float densityExp = m_FogParams.density * 1.4426950408f;
                    FXMaterial.SetFloat(TOD_PropertyIDs.f_DensityID, densityExp);

                break;

                case FogMode.ExponentialSquared:

                    pass = 2;
                    float densityExp2 = m_FogParams.density * 1.2011224087f;
                    FXMaterial.SetFloat(TOD_PropertyIDs.f_DensityID, densityExp2);

                break;

            }
            CustomBlit(source, destination, FXMaterial, pass);
        }
    }
}