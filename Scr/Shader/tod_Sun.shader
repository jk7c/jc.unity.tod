Shader "TOD Sky/Near Space/Sun"
{
    //Properties{}
    SubShader
    {
        Tags{ "Queue"="Background+15" "RenderType"="Background" "IgnoreProjector"="true" }
        Pass
        {

            Cull Front ZWrite Off ZTest Lequal 
            Fog{ Mode Off }

            CGPROGRAM
            #include "UnityCG.cginc"
            #include "tod_Include.hlsl"

            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            struct v2f
            {
                float2 texcoord : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                half3  col      : TEXCOORD2;
                float4 vertex   : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            uniform sampler2D TOD_SunTex;
            uniform half4 TOD_SunTint;
            uniform half  TOD_SunIntensity;

            v2f vert(appdata_base v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.vertex   = UnityObjectToClipPos(v.vertex);
                o.worldPos = TOD_WORLD_POS(v.vertex);
                o.texcoord = v.texcoord;
                o.col.rgb  = TOD_SunTint.rgb * TOD_SunIntensity * TOD_GlobalIntensity;

                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 col = tex2D(TOD_SunTex, i.texcoord);
                col.rgb   *= i.col.rgb * TOD_WORLD_HORIZON_FADE(i.worldPos);
                return col;
            }   
            ENDCG
        }
    }

}