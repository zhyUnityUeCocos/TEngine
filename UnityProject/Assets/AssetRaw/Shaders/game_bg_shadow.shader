Shader "Kein/game_bg_shadow"
{
    Properties
    {
        _Color("Color1",Color)=(1,1,1,1)
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
            #pragma fragment frag
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSort.cginc"

            fixed4 frag(v2f_block i) : SV_Target
            {
                fixed4 col = _Color;
                //fixed3 worldNormal = normalize(i.worldNormal);
                //fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                //fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.5 + 0.5) * _LightColor0.rgb * 1.1;
                //fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                //fixed3 halfDir = normalize(worldLightDir + viewDir);
                //col.rgb *= _Color.rgb;
                //fixed3 lightCol = col.rgb * difCol;
                float shadow = SHADOW_ATTENUATION(i);
                fixed3 shadowCol = lerp(col * 0.9, col, shadow);
                return fixed4(shadowCol, 1.0);
            }
            ENDCG
        }
    }
    FallBack"Kein/shadowcast"
}
