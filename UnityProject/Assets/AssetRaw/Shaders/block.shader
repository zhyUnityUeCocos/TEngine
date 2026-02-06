Shader "Kein/block/block"
{
    Properties
    {
        _Color("Color1",Color)=(1,1,1,1)

        [HideInInspector]_Color2("Color2",Color)=(1,1,1,1)
        [HideInInspector]_Color3("Color3",Color)=(1,1,1,1)
        [HideInInspector]_Color4("Color4",Color)=(1,1,1,1)


        /*[HideInInspector]*/_MainTex ("Texture", 2D) = "white" {}
        _RimIntensity("Rim Intensity",Range(0,1)) = 0.5
        _RimColor("Rim Color",Color) = (1,1,1,1)
        _SpecularIntensity("Specular Intensity",Range(0,1)) = 0.5
        _SpecularColor("Specular Color", Color) = (1,1,1,1)
        _Gloss("Gloss", Range(8.0,256)) = 20

        // 程序控制
        [HideInInspector]_IsChoiced("Is Choiced",float) = 0
        [HideInInspector]_IsUnLock("Is UnLock",Range(0,1)) = 0
        [HideInInspector]_IsRemove("Is Remove",Range(0,1)) = 0
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
            #pragma fragment frag_block
            #include "Assets/Kein-CG/Common/KeinHexaSort.cginc"
            ENDCG
        }
    }
    FallBack"Kein/shadowcast"
}
