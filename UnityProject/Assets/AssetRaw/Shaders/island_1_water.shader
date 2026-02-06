Shader "Kein/island/water1"
{
    Properties
    {
        _Color("Color",Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags {"Queue" = "Transparent+1" "IgnoreProjector" = "True" "RenderType " = "Transparent"}
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull Off
            CGPROGRAM
            #pragma vertex vert_island1_water
            #pragma fragment frag_island1_water
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSortUnlit.cginc"
            ENDCG
        }
    }
}
