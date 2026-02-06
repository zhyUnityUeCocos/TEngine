Shader "Kein/block/build"
{
    Properties
    {
        [HideInInspector]_MainTex ("Texture", 2D) = "white" {}
        _RimIntensity("Rim Intensity",Range(0,1)) = 0.5
        [HideInInspector]_RimColor("Rim Color",Color) = (1,1,1,1)
        _SpecularIntensity("Specular Intensity",Range(0,1)) = 0.5
        [HideInInspector]_SpecularColor("Specular Color", Color) = (1,1,1,1)
        _Gloss("Gloss", Range(8.0,256)) = 20

        [HideInInspector]_RangeColor("Range Color",Range(1,7)) = 1
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
            #pragma fragment frag_build
            #include "Assets/Kein-CG/Common/KeinHexaSort.cginc"
            ENDCG
        }
    }
    //FallBack"Kein/shadowcast"
}
