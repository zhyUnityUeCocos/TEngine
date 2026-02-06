Shader "Kein/block/trail"
{
    Properties
    {
        //_Color("Color",Color)=(1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _RangeColor("Range Color",Range(1,7)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_BlockTrail
            #pragma fragment frag_BlockTrail
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSortUnlit.cginc"
            ENDCG
        }
    }
}
