Shader "Kein/block/ad"
{
    Properties
    {
        [HideInInspector]_Color("Color",Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType " = "Transparent"}
        Pass
        {
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #include "Lighting.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase
            #pragma vertex vert_Shadow
            #pragma fragment frag_block_ad
            #include "Assets/Kein-CG/Common/KeinHexaSort.cginc"
            ENDCG
        }
    }
}
