Shader "Kein/block/trail2"
{
    Properties
    {
        // _Color("Color",Color) = (1,1,1,1)
        [HideInInspector]_MainTex ("Texture", 2D) = "white" {}
        [HideInInspector]_RangeColor("Range Color",Range(1,7)) = 1
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType " = "Transparent"}
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert_BlockTrail
            #pragma fragment frag_BlockTrail
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSortUnlit.cginc"
            ENDCG
        }
    }
}
