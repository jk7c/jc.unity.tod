﻿Shader "TOD Sky/Legacy/Post Processing/Fog"
{
    Properties{}
    SubShader
    {

        CGINCLUDE
        #define TOD_ENABLE_MIE_PHASE 1
        #define TOD_POST_PROCESSING 1

        #include "UnityCG.cginc"
        #include "tod_Include.hlsl"
        #include "tod_PHATMSCommon.hlsl"
        #include "tod_FogCommon.hlsl"

        #pragma multi_compile __ TOD_ATMS_APPLY_FAST_TONEMAP
        #pragma multi_compile __ TOD_ENABLE_MOON_RAYLEIGH

        uniform sampler2D _MainTex;
        uniform sampler2D_float _CameraDepthTexture;
        float4 _MainTex_TexelSize;

        uniform float4x4 TOD_FrustumCorners; 
        uniform float3 TOD_CameraPos;
        uniform float TOD_FogDensity;
        uniform float TOD_FogStartDistance, TOD_FogEndDistance;

        struct v2f
        {
            float2 uv        : TEXCOORD0;
            float4 interpRay : TEXCOORD1;
            float4 vertex    : SV_POSITION;
            UNITY_VERTEX_OUTPUT_STEREO
        };

        v2f vert (appdata_img v)
        {
            v2f o; 
           // UNITY_INITIALIZE_OUTPUT(v2f, o);
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

            v.vertex.z = 0.1;
            o.vertex   = UnityObjectToClipPos(v.vertex);
            o.uv       = v.texcoord.xy;

            #if UNITY_UV_STARTS_AT_TOP

                if(_MainTex_TexelSize.y < 0)
                    o.uv.y = 1-o.uv.y;

            #endif

            int index       = v.texcoord.x + (2.0 * o.uv.y);
            o.interpRay     = TOD_FrustumCorners[index];
            o.interpRay.xyz = mul((float3x3)TOD_WorldToObject, o.interpRay.xyz);
            o.interpRay.w   = index;	
            return o;
        }

        inline half4 SceneColor(sampler2D tex, float2 uv)
        {
            return tex2D(tex, UnityStereoTransformScreenSpaceTex(uv));
        }

        inline float SceneDepth(float2 uv)
        {
            float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, UnityStereoTransformScreenSpaceTex(uv));
            return Linear01Depth(depth);
        }

        half3 GetAtmosphereColor(float3 viewDir, float depth, float dist)
        {
            half3 re = fixed3(0.0, 0.0, 0.0);
            float3 viewDirNormal = normalize(viewDir.xyz);

            half3 sunMiePhase, moonMiePhase;
            re = TOD_RenderPHATMS(viewDirNormal.xyz, sunMiePhase, moonMiePhase, float2(depth, dist));

            return re;
        }

        half4 RenderLinearFog(v2f i) : SV_Target
        {
            half4 c        = SceneColor(_MainTex, i.uv);
            float depth    = SceneDepth(i.uv);
            float3 viewDir = (depth * i.interpRay.xyz); // float3 vp = _WorldSpaceCameraPos + viewDir;

            float fog = TOD_FogLinearFactor(depth, float2(TOD_FogStartDistance, TOD_FogEndDistance));
            fog *= (depth < 0.9999);

            half3 scatter = GetAtmosphereColor(viewDir, depth, fog);
            c.rgb = lerp(c.rgb, scatter, fog);

            return c;
        }

        half4 RenderExpFog(v2f i) : SV_Target
        {
            half4 c        = SceneColor(_MainTex, i.uv);
            float depth    = SceneDepth(i.uv);
            float3 viewDir = (depth * i.interpRay.xyz); // float3 vp = _WorldSpaceCameraPos + viewDir;

            float fog = TOD_FogExpFactor(depth, TOD_FogDensity);
            fog *= (depth < 0.9999);

            half3 scatter = GetAtmosphereColor(viewDir, depth, fog);

            c.rgb = lerp(c.rgb, scatter.rgb, fog);

            return c;
        }

        half4 RenderExp2Fog(v2f i) : SV_Target
        {
            half4 c        = SceneColor(_MainTex, i.uv);
            float depth    = SceneDepth(i.uv);
            float3 viewDir = (depth * i.interpRay.xyz); // float3 vp = _WorldSpaceCameraPos + viewDir;

            float fog = TOD_FogExp2Factor(depth, TOD_FogDensity);
            fog *= (depth < 0.9999);

            half3 scatter = GetAtmosphereColor(viewDir, depth, fog);
            c.rgb = lerp(c.rgb, scatter, fog);
            
            return c;
        }
        ENDCG

        // Linear
        Pass
        {
            Cull Off ZWrite Off ZTest Always

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment RenderLinearFog
            ENDCG
        }

        // Exp
        Pass
        {
            Cull Off ZWrite Off ZTest Always

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment RenderExpFog
            ENDCG
        }

        // Exp2
        Pass
        {
            Cull Off ZWrite Off ZTest Always

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment RenderExp2Fog
            ENDCG
        }
    }
}
