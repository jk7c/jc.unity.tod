Shader "TOD Sky/Skydome/Preetham And Hoffman Atmosphere"
{

    SubShader
    {
        CGINCLUDE

        #define TOD_ENABLE_MIE_PHASE 1

        #include "UnityCG.cginc"
        #include "tod_Include.hlsl"
        #include "tod_PHATMSCommon.hlsl" 

        #pragma multi_compile __ TOD_ATMS_APPLY_FAST_TONEMAP
        #pragma multi_compile __ TOD_PER_PIXEL_ATMOSPHERE
        #pragma multi_compile __ TOD_ENABLE_MOON_RAYLEIGH
        

        struct appdata
        {
            float4 vertex : POSITION;
            float2 texcoord : TEXCOORD0;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        struct v2f
        {
            float3 nvertex    : TEXCOORD0; 
            half3 sunMiePhase : TEXCOORD1;
            half4 moonMiePhase: TEXCOORD2;
            #ifndef TOD_PER_PIXEL_ATMOSPHERE
            half3 scatter : TEXCOORD3;
            #endif
            float4 vertex : SV_POSITION;
            UNITY_VERTEX_OUTPUT_STEREO
        };

        v2f vert(appdata v)
        {
            v2f o;
            UNITY_INITIALIZE_OUTPUT(v2f, o);
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

            o.vertex = TOD_DomeToClipPos(v.vertex);
            o.nvertex = normalize(v.vertex.xyz);

            #ifndef TOD_PER_PIXEL_ATMOSPHERE
            o.scatter.rgb = TOD_RenderPHATMS(o.nvertex.xyz, o.sunMiePhase, o.moonMiePhase.rgb, TOD_One2);
            #endif

            return o;
        }

        half4 frag(v2f i) : SV_Target
        {
            half4 col = half4(0.0, 0.0, 0.0, 0.95);
            #ifndef TOD_PER_PIXEL_ATMOSPHERE
            col.rgb = i.scatter;
            #else
            i.nvertex.xyz = normalize(i.nvertex.xyz);
            col.rgb = TOD_RenderPHATMS(i.nvertex.xyz, i.sunMiePhase, i.moonMiePhase.rgb, TOD_One2);
            #endif

            return col;
        }
        ENDCG

        Tags{ "Queue"="Background+1000" "RenderType"="Background" "IgnoreProjector"="True" }
        Pass
        {
            Cull Front ZWrite Off ZTest LEqual //Blend One One
            Blend SrcAlpha OneMinusSrcAlpha
            //Fog{ Mode Off }
            
            CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag 
                #pragma target 2.0

            ENDCG
        }
    }

}