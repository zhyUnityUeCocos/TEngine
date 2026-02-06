Shader "Kein/Skybox/Horizontal"
{
    Properties
    {
        _Color1 ("Top Color", Color) = (1, 1, 1, 0)
        _Color2 ("Horizon Color", Color) = (1, 1, 1, 0)
        _Color3 ("Bottom Color", Color) = (1, 1, 1, 0)
        _Exponent1 ("Exponent Factor for Top Half", Float) = 1.0
        _Exponent2 ("Exponent Factor for Bottom Half", Float) = 1.0
        _Intensity ("Intensity Amplifier", Float) = 1.0
        _Color4 ("tex Color", Color) = (1, 1, 1, 0)
        _MainTex("Texture", 2D) = "white" {}
        _MainTex2("noise", 2D) = "white" {}

        _FogColor ("Fog Color", Color) = (1, 1, 1, 0)
        _AmbientColor ("Ambient Color", Color) = (1, 1, 1, 0)
        _LightColor ("Light Color", Color) = (1, 1, 1, 0)
        _LightIntensity("Light Intensity",float) = 0.5
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct appdata
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    struct v2f
    {
        float4 position : SV_POSITION;
        float3 texcoord : TEXCOORD0;
        float4 uv : TEXCOORD1;
    };
    
    half4 _Color1;
    half4 _Color2;
    half4 _Color3;
    half4 _Color4;
    fixed4 _FogColor,_AmbientColor,_LightColor;
    float _LightIntensity;

    half _Intensity;
    half _Exponent1;
    half _Exponent2;
    sampler2D _MainTex,_MainTex2;
    float4 _MainTex_ST,_MainTex2_ST;

    v2f vert (appdata v)
    {
        v2f o;
        o.position = UnityObjectToClipPos (v.position);
        o.texcoord = v.texcoord;
       
        o.uv.xy = TRANSFORM_TEX(v.texcoord.xy, _MainTex);
        o.uv.zw = TRANSFORM_TEX(v.texcoord.xy, _MainTex2);
        return o;
    }
    
    half4 frag (v2f i) : SV_Target
    {
        //i.uv.x = normalize (i.uv.x);
        //i.uv.x = 2;
        half4 texCol = tex2D(_MainTex,i.uv.xy) * _Color4;
        i.uv.z += _Time.y * 0.2;
        i.uv.w -= _Time.y * 0.2;
        half4 nosCol = tex2D(_MainTex2,i.uv.zw);

        texCol *= nosCol;

        float p = normalize (i.texcoord).y;
        float p1 = 1.0f - pow (min (1.0f, 1.0f - p), _Exponent1);
        float p3 = 1.0f - pow (min (1.0f, 1.0f + p), _Exponent2);
        float p2 = 1.0f - p1 - p3;
        half4 col = (_Color1 * p1 + _Color2 * p2 + _Color3 * p3) * _Intensity;
        half4 finCol = col + texCol;
        return finCol;
    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Background" "Queue"="Background" }
        Pass
        {
            ZWrite Off
            Cull Off
            Fog { Mode Off }
            CGPROGRAM
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
}
