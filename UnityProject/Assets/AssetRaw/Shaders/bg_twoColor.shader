Shader "Kein/Bg/twoColor"
{
    Properties
    {
        _Color1 ("Top Color", Color) = (1, 1, 1, 0)
        _Color2 ("Bottom Color", Color) = (1, 1, 1, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Background" "Queue"="Background" }
        Pass
        {
            ZWrite Off
            Cull Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag_TwoCol
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSortUnlit.cginc"
            ENDCG
        }
    }
}
