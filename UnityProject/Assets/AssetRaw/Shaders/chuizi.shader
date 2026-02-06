Shader "Kein/block/chuizi"
{
    Properties
    {
        _Color("Color1",Color)=(1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _RimIntensity("Rim Intensity",Range(0,1)) = 0.5
        _RimColor("Rim Color",Color) = (1,1,1,1)
        _SpecularIntensity("Specular Intensity",Range(0,1)) = 0.5
        _SpecularColor("Specular Color", Color) = (1,1,1,1)
        _Gloss("Gloss", Range(8.0,256)) = 20
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
            #pragma vertex vert_block
            #pragma fragment frag_chuizi
            #include "Assets/Kein-CG/Common/KeinHexaSort.cginc"
            ENDCG
        }
    }
    FallBack"Kein/shadowcast"
}
