Shader "Kein/island/balloon"
{
    Properties
    {
        _Color("Color1",Color)=(1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _RimIntensity("Rim Intensity",Range(0,1)) = 0.5
        _RimColor("Rim Color",Color) = (1,1,1,1)
        [HideInInspector][Gamma]_AniVector("Ani Vector",Vector)=(0,0,0,0)  
        [HideInInspector]_IsUnLock("Is UnLock",Range(0,1)) = 0
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
            #pragma vertex vert_balloon
            #pragma fragment frag_tree
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
               if(v.color.b < 0.5f)
    {
        v.vertex.y += sin(_Time.y );
        v.vertex.x += sin(_Time.y * 0.5) * 0.5;
        v.vertex.z -= sin(_Time.y * 0.3) * 0.6;
    }
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
   // FallBack"Kein/shadowcast"
}
