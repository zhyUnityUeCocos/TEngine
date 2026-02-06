Shader "Kein/Bg/gameBg"
{
    Properties
    {
        _Color("Color1",Color) = (1,1,1,1)
        _MainTex("Texture", 2D) = "white" {}

    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry+2" }
        Pass
        {
            Tags{"LightMode" = "ForwardBase"}
            //Blend SrcAlpha OneMinusSrcAlpha
            //Stencil {
            //    Ref 2   
            //    Comp always 
            //    Pass replace  
            //}
            ZWrite On
            CGPROGRAM
            #include "Lighting.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase
            #pragma vertex vert_gameBg
            #pragma fragment frag_bg
            #include "Assets/Kein-CG/Common/KeinHexaSort.cginc"
            ENDCG
        }
    }
        FallBack"Kein/shadowcast"
}
