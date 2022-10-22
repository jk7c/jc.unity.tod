Shader "TOD Sky/Deep Space"
{

    //Properties{}
    CGINCLUDE  
    #include "UnityCG.cginc"
    #include "tod_Include.hlsl"

    // Cubemap.
    ////////////////
    uniform samplerCUBE TOD_GalaxyBackgroundCubemap;
    uniform samplerCUBE TOD_StarsFieldCubemap;
    uniform samplerCUBE TOD_StarsFieldNoiseCubemap;

    //#ifndef SHADER_API_MOBILE
    //half4 TOD_DeepSpace_HDR;
    //#endif

    uniform float4x4 TOD_StarsFieldNoiseMatrix;
    #define TOD_STARS_FIELD_NOISE_COORDS(vertex) mul((float3x3) TOD_StarsFieldNoiseMatrix, vertex.xyz)

    // Params
    //////////////
    uniform half3 TOD_GalaxyBackgroundTint;
    uniform half  TOD_GalaxyBackgroundIntensity;
    uniform half  TOD_GalaxyBackgroundContrast;

    uniform half3 TOD_StarsFieldTint;
    uniform half  TOD_StarsFieldIntensity;
    uniform half  TOD_StarsFieldScintillation;
    uniform half  TOD_StarsFieldScintillationSpeed;
   
    struct v2f
    {
        float4 vertex    : SV_POSITION;
        float3 texcoord  : TEXCOORD0;
        float3 texcoord2 : TEXCOORD1;
        half3  col       : TEXCOORD2;
        UNITY_VERTEX_OUTPUT_STEREO
    };

    v2f vert(appdata_base v)
    {
        v2f o;
        //UNITY_INITIALIZE_OUTPUT(v2f, o);
        UNITY_SETUP_INSTANCE_ID(v);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
        o.vertex    = TOD_DomeToClipPos(v.vertex);
        o.texcoord  = v.vertex.xyz;
        o.texcoord2 = TOD_STARS_FIELD_NOISE_COORDS(v.vertex);
        o.col.rgb   = TOD_HORIZON_FADE(v.vertex) * TOD_GlobalIntensity;
        return o;
    }

    inline half3 ApplyScintillation(half3 c, float3 coords)
    {
        fixed noiseCube = texCUBE(TOD_StarsFieldNoiseCubemap, coords).r;
        return lerp(c.rgb, 2.0 * c.rgb * noiseCube, TOD_StarsFieldScintillation);
    }

    fixed4 frag(v2f i) : SV_Target
    {
        // Galaxy Background.
        fixed3 galaxy = texCUBE(TOD_GalaxyBackgroundCubemap, i.texcoord.rgb);
        galaxy = TOD_Pow3(galaxy, TOD_GalaxyBackgroundContrast);
        galaxy *= TOD_GalaxyBackgroundTint * TOD_GalaxyBackgroundIntensity * i.col.rgb;

        // Stars Field.
        fixed3 starsField  = texCUBE(TOD_StarsFieldCubemap, i.texcoord).rgb;
        starsField.rgb     = ApplyScintillation(starsField.rgb, i.texcoord2.xyz);
        starsField.rgb    *= TOD_StarsFieldTint.rgb * i.col.rgb * TOD_StarsFieldIntensity;

        fixed4 re = fixed4(galaxy.rgb + starsField.rgb, 1.0);
        //#ifndef SHADER_API_MOBILE
        //re.rgb = DecodeHDR(re, TOD_DeepSpace_HDR);
        //re.rgb *= unity_ColorSpaceDouble.rgb;
        //#endif

        return re;
    }

    ENDCG

    SubShader
    {
        Tags{ "Queue"="Background+5" "RenderType"="Background" "IgnoreProjector"= "true" }
        Pass
        {
            Cull Front ZWrite Off ZTest Lequal
            //Blend One One
            Fog{ Mode Off }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            ENDCG
        }
    }

}