Shader "Kein/island/4_river"
{
    Properties
    {
        _Color("Color1",Color)=(1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _RimIntensity("Rim Intensity",Range(0,1)) = 0.5
        _RimColor("Rim Color",Color) = (1,1,1,1)
    }
    SubShader
    {
        Pass
        {
            Tags{"LightMode" = "ForwardBase"}

            ZWrite On
            Cull Back

            CGPROGRAM
            #include "Lighting.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase
            #pragma vertex vert_island4river
            #pragma fragment frag_island_4river
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSort.cginc"
            ENDCG
        }
    
     Pass
        {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"
            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal:NORMAL;
                fixed4 color : COLOR;
            };
            struct v2f
            {
               V2F_SHADOW_CASTER;     
            };
            float4 _AniVector;
            v2f vert (a2v v) 
           {
               v2f o;
               TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
               return o;
           }
           fixed4 frag (v2f i) :SV_Target
           {
               SHADOW_CASTER_FRAGMENT(i);
           }
           ENDCG
        }
        }

}
