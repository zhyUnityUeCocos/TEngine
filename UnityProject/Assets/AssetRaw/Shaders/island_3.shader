Shader "Kein/island/3"
{
    Properties
    {
        _Color("Color1",Color)=(1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _RimIntensity("Rim Intensity",Range(0,1)) = 0.5
        _RimColor("Rim Color",Color) = (1,1,1,1)
        // 程序控制
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
            #pragma vertex vert_island3
            #pragma fragment frag_island_1
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
               if(v.color.g < 0.5f)
    {
        //float dis = distance(v.vertex.xyz, float3(0,0,0));
        float dis = v.vertex.y ;
        v.vertex.x -= sin(_Time.y ) * dis * dis * 0.005f;
        v.vertex.y += sin(-_Time.y ) * dis * dis * 0.005f;
        v.vertex.z -= cos(-_Time.y ) * dis * dis * 0.005f;
    }
    if(v.color.r < 0.5f)
    {
        float dis = v.vertex.y ;
        v.vertex.z -= sin(_Time.y * 0.5);
        v.vertex.x -= sin(_Time.y * 0.5);
        v.vertex.y += sin(-_Time.y * 20) * dis * dis * 0.2;
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

}
