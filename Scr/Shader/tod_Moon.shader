Shader "TOD Sky/Near Space/Moon"
{
    //Properties{}
    SubShader
    {
        Tags{ "Queue"="Background+20" "RenderType"="Background" "IgnoreProjector"="true" }
       

        Pass
        {
            ZWrite Off ZTest Lequal //Blend One One
            Fog{ Mode Off }

            CGPROGRAM
            #include "UnityCG.cginc"
            #include "tod_Include.hlsl"
            //--------------------------------
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            //--------------------------------
            uniform sampler2D TOD_MoonTex;
            float4 TOD_MoonTex_ST;
            //--------------------------------
            uniform half  TOD_MoonIntensity;
            uniform half3 TOD_MoonTint;
            uniform half  TOD_MoonContrast;
            //--------------------------------

            struct v2f
            {
                float2 texcoord : TEXCOORD0;
                float3 normal   : TEXCOORD1;
                half3  col      : TEXCOORD2;
                float4 vertex   : SV_POSITION;
			    UNITY_VERTEX_OUTPUT_STEREO
            };

            v2f vert(appdata_base v)
            {

                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o);
	
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.vertex    = UnityObjectToClipPos(v.vertex);
                float3 Pos  = TOD_WORLD_POS(v.vertex);
			    o.normal    = normalize(mul((float3x3)unity_ObjectToWorld, v.normal));
			    o.texcoord  = TRANSFORM_TEX(v.texcoord.xy, TOD_MoonTex);

			    o.col.rgb = TOD_MoonTint.rgb * saturate(max(0.0, dot(TOD_WorldSunDirection.xyz, o.normal)) * 2.0) * TOD_MoonIntensity;
                o.col.rgb *= TOD_WORLD_HORIZON_FADE(Pos) * TOD_GlobalIntensity;

			    return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return fixed4(i.col.rgb * TOD_Pow3(tex2D(TOD_MoonTex, i.texcoord).rgb, TOD_MoonContrast), 1);
            }

            ENDCG
        }
    }

}