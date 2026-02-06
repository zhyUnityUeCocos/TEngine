Shader "Hp/blockIce"
{
    Properties
    {
        _Color("Color1",Color) = (1,1,1,1)
        _MainTex("Texture", 2D) = "white" {}
        _AlphaTex("AlphaTex", 2D) = "white" {}
        _LightPower("LightPower",Float) = 1
    }

    SubShader
    {
        Pass
        {
            Tags{"Queue" = "Transparent" "LightMode" = "ForwardBase"}

            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #include "Lighting.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase
            #pragma vertex vert_block
            #pragma fragment frag
            #include "Assets/_Art/Kein-CG/Common/KeinHexaSort.cginc"

            float _LightPower;
            sampler2D _AlphaTex;

            fixed4 frag(v2f_block i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex,i.uv) * _Color * _LightPower;
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.5 + 0.5) * _LightColor0.rgb * 1.1;
                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                fixed3 halfDir = normalize(worldLightDir + viewDir);
                col.rgb *= _Color.rgb;
                fixed3 lightCol = col.rgb * difCol;
                float shadow = SHADOW_ATTENUATION(i);
                fixed3 shadowCol = lerp(lightCol * 0.9, lightCol, shadow);

                if (tex2D(_AlphaTex, i.uv).r == 0)
                {
                    return fixed4(shadowCol, 0.9);
                }

                return fixed4(shadowCol, col.a);
            }
            ENDCG
        }
    }
    FallBack"Kein/shadowcast"
}
