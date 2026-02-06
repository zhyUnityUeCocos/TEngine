#ifndef KEIN_FRAG
#define KEIN_FRAG
fixed4 frag_noTex (v2f_color i) : SV_Target
{
    return _Color;
}
fixed4 frag_tex (v2f i) : SV_Target
{
    return tex2D(_MainTex, i.uv);
}
fixed4 frag (v2f i) : SV_Target
{
    return tex2D(_MainTex, i.uv) * _Color;
}
fixed4 frag_color (v2f_color i) : SV_Target
{
    return tex2D(_MainTex, i.uv) * _Color * i.color;
}

fixed4 frag_block (v2f_block i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv);
    //if(i.uv.x > 0.5 && i.uv.y > 0.5)
    //{
    //    col.rgb = _Color2.rgb;
    //}
    //else if(i.uv.x < 0.5 && i.uv.y < 0.5)
    //{
    //    col.rgb = _Color3.rgb;
    //}
    //else if(i.uv.x > 0.5 && i.uv.y < 0.5)
    //{
    //    col.rgb = _Color4.rgb;
    //}
    //else
    //{
    //    col.rgb = _Color.rgb;
    //}
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.5 + 0.5) * _LightColor0.rgb * 1.1;
    fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 halfDir = normalize(worldLightDir + viewDir);
    fixed3 speCol = _LightColor0.rgb * _SpecularColor.rgb * pow(max(0,dot(worldNormal, halfDir)), _Gloss);
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,0.8,2.85);
    col.rgb *= _Color.rgb;
    fixed3 lightCol = col.rgb * difCol + rimColor * _RimIntensity + speCol * _SpecularIntensity;
    // fixed3 lightCol = col.rgb * difCol;
    float shadow = SHADOW_ATTENUATION(i);
    fixed3 shadowCol = lerp(lightCol * 0.9, lightCol, shadow);
    shadowCol.rgb *= _IsChoiced > 0.5 ? 1.3 : 1;
    shadowCol.rgb = _IsRemove > 0.5 ? fixed3(1,1,1) : shadowCol.rgb;
    shadowCol.rgb *= _IsUnLock < 0.5 ? fixed3(0.35, 0.5, 0.45) * 1.3 : 1;
    return fixed4(shadowCol, 1.0);
}
fixed4 frag_block_ad (v2f_Shadow i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    fixed shadow = SHADOW_ATTENUATION(i);
    col.rgb = lerp(col.rgb * 0.8, col.rgb, shadow);
    return col;
}
fixed4 frag_build (v2f_block i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv);
    col.rgb *= Kein7Color(_RangeColor);
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.5 + 0.5) * _LightColor0.rgb * 2.5;
    fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 halfDir = normalize(worldLightDir + viewDir);
    fixed3 speCol = _LightColor0.rgb * _SpecularColor.rgb * pow(max(0,dot(worldNormal, halfDir)), _Gloss);
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1,4);
    fixed3 lightCol = col.rgb * difCol + rimColor * _RimIntensity + speCol * _SpecularIntensity;
    return fixed4(lightCol, 1.0);
}
fixed4 frag_chuizi (v2f_block i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv);
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.5 + 0.5) * _LightColor0.rgb;
    fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 halfDir = normalize(worldLightDir + viewDir);
    fixed3 speCol = _LightColor0.rgb * _SpecularColor.rgb * pow(max(0,dot(worldNormal, halfDir)), _Gloss);
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,0.8,2.85);
    col.rgb *= _Color.rgb;
    fixed3 lightCol;
    if(i.uv.x < 0.5)
    {
        lightCol = col.rgb * difCol + rimColor * _RimIntensity + speCol * _SpecularIntensity;
    }
    else
    {
        lightCol = col.rgb * difCol + rimColor * _RimIntensity;
    }
    float shadow = SHADOW_ATTENUATION(i);
    fixed3 shadowCol = lerp(lightCol * 0.9, lightCol, shadow);
    return fixed4(shadowCol, 1.0);
}
fixed4 frag_bg(v2f_Shadow i) : SV_Target
{
    /*fixed4 col = fixed4(1,1,1,1);
    col.rgb = lerp(fixed3(0.24,0.53,0.65),fixed3(0.24,0.43,0.63),i.uv.y);
    float shadow = SHADOW_ATTENUATION(i);
    col.rgb = lerp(col.rgb * 0.9, col.rgb, shadow);
    return col;*/
    return _Color;
}
fixed4 frag_island_1 (v2f_tree i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.4 + 0.6) * _LightColor0.rgb * 1.8;
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1.5,4);
    fixed3 lightCol = col.rgb * difCol + rimColor * _RimIntensity;
    float shadow = SHADOW_ATTENUATION(i);
    fixed3 finalCol = _IsUnLock < i.uv.w ?  difCol * 0.2  + rimColor * 0.02: lightCol;
    //fixed3 finalCol = lightCol;
    finalCol = lerp(finalCol * 0.7, finalCol, shadow);
    return fixed4(finalCol, 1.0);
}
fixed4 frag_island (v2f_island i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.4 + 0.6) * _LightColor0.rgb * 1.8;
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1.5,4);
    fixed3 lightCol = col.rgb * difCol + rimColor * _RimIntensity;
    float shadow = SHADOW_ATTENUATION(i);
    //fixed3 finalCol = _IsUnLock < i.uv.w ?  difCol * 0.2  + rimColor * 0.02: lightCol;
    fixed3 finalCol = i.unlit > 0.5 ? lightCol : col.rgb;


    finalCol = lerp(finalCol * 0.7, finalCol, shadow);
    return fixed4(finalCol, 1.0);
}
fixed4 frag_island9 (v2f_island i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1.5,4);
    fixed3 lightCol = col.rgb + rimColor * _RimIntensity;
    float shadow = SHADOW_ATTENUATION(i);
    fixed3 finalCol = i.unlit > 0.5 ? lightCol : col.rgb;
    finalCol = lerp(finalCol * 0.9 * fixed3(0.7,0.9,1), finalCol, shadow);
    return fixed4(finalCol, 1.0);
}
fixed4 frag_island_9build (v2f_tree i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1.5,4);
    fixed3 lightCol = col.rgb + rimColor * _RimIntensity;
    float shadow = SHADOW_ATTENUATION(i);
    fixed3 finalCol = _IsUnLock < i.uv.w ?  col * 0.2  + rimColor * 0.02: lightCol;
    finalCol = lerp(finalCol * 0.9 * fixed3(0.7,0.9,1), finalCol, shadow);
    return fixed4(finalCol, 1.0);
}

fixed4 frag_island_4river (v2f_tree i) : SV_Target
{
    float2 uv = i.uv;
    uv.y += _Time.y * 0.15;
    fixed4 col = tex2D(_MainTex, uv) * _Color;
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.4 + 0.6) * _LightColor0.rgb * 1.8;
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1.5,4);
    fixed3 lightCol = col.rgb * difCol + rimColor * _RimIntensity;
    float shadow = SHADOW_ATTENUATION(i);
    
    fixed3 lc = lerp(fixed3(1,1,1),fixed3(0,0,0), abs((i.uv.y * 0.3 - 0.5) * 2) );
    fixed3 finalCol = lightCol + lc * 0.3;
    finalCol = lerp(finalCol * 0.7, finalCol, shadow);
    return fixed4(finalCol, 1.0);
}
fixed4 frag_tree (v2f_tree i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 difCol = (dot(worldNormal, worldLightDir) * 0.3 + 0.7) * _LightColor0.rgb * 2.3;
    fixed3 rimColor = KeinRimCol(i.worldNormal,i.worldViewDir,_RimColor,1.5,4);
    fixed3 lightCol = col.rgb * difCol + rimColor * _RimIntensity;
    float shadow = SHADOW_ATTENUATION(i);
    fixed3 finalCol = lightCol;
    finalCol = _IsUnLock < i.uv.w ? difCol * 0.1  + rimColor * 0.02: lightCol;
    finalCol = lerp(finalCol * 0.7, finalCol, shadow);
    return fixed4(finalCol, 1.0);
}
#endif


