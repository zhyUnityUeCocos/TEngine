#ifndef KEIN_VERT
#define KEIN_VERT

v2f vert(a2v v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    return o;
}
v2f vert_till(a2v v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    return o;
}
v2f_color vert_color (a2v_color v)
{
    v2f_color o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    o.color = v.color;
    return o;
}
v2f_color vert_color_noTill (a2v_color v)
{
    v2f_color o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    o.color = v.color;
    return o;
}
v2f_uv4 vert_uv4(a2v v)
{
    v2f_uv4 o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
    o.uv.zw = v.uv;
    return o;
}
v2f_rim vert_rim (a2v_normal v)
{
    v2f_rim o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    return o;
}
v2f_rim4 vert_rim_uv4 (a2v_normal v)
{
    v2f_rim4 o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
    o.uv.zw = v.uv;
    return o;
}
v2f_rim_matCap vert_rim_matCap (a2v_normal v)
{
    v2f_rim_matCap o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.matCap = Kein_MatCapUV(v.normal);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    return o;
}
v2f_Shadow vert_Shadow(a2v v)
{
    v2f_Shadow o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    TRANSFER_SHADOW(o);
    return o;
}
v2f_gameBg vert_gameBg(a2v v)
{
    v2f_Shadow o;
    //float dis = distance(v.vertex.)
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    TRANSFER_SHADOW(o);
    return o;
}

// HS
v2f_block vert_block (a2v_normal v)
{
    v2f_block o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_tree (a2v_tree v)
{
    v2f_tree o;
    if(v.color.r < 0.5f)
    {
        float dis = distance(v.vertex.xyz, float3(0,0,0));

        v.vertex.x += sin(_Time.y ) * dis * dis * 0.004f;
        v.vertex.y += sin(-_Time.y ) * dis * 0.005f;
        v.vertex.z += cos(-_Time.y ) * dis * dis * 0.004f;


        v.vertex.x += _AniVector.x * dis * dis * 0.004f;
        v.vertex.y += _AniVector.y * dis * 0.005f;
        v.vertex.z += _AniVector.z * dis * dis * 0.004f;
    }
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_balloon (a2v_tree v)
{
    v2f_tree o;
    if(v.color.b < 0.5f)
    {
        v.vertex.y += sin(_Time.y );
        v.vertex.x += sin(_Time.y * 0.5) * 0.5;
        v.vertex.z -= sin(_Time.y * 0.3) * 0.6;
    }
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_island (a2v_tree v)
{
    v2f_tree o;
    if(v.color.r < 0.5f)
    {
        //float dis = distance(v.vertex.xyz, float3(0,0,0));
        float dis = v.vertex.y ;
        v.vertex.x -= sin(_Time.y ) * dis * dis * 0.005f;
        v.vertex.y += sin(-_Time.y ) * dis * dis * 0.005f;
        v.vertex.z -= cos(-_Time.y ) * dis * dis * 0.005f;
    }
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_island3 (a2v_tree v)
{
    v2f_tree o;
    if(v.color.g < 0.5f)
    {
        //float dis = distance(v.vertex.xyz, float3(0,0,0));
        float dis = v.vertex.y ;
        v.vertex.x -= sin(_Time.y ) * dis * dis * 0.005f;
        v.vertex.y += sin(-_Time.y ) * dis * dis * 0.005f;
        v.vertex.z -= cos(-_Time.y ) * dis * dis * 0.005f;
    }
    if(v.color.r < 0.5f)
    {
        float dis = v.vertex.y ;
        v.vertex.z -= sin(_Time.y * 0.5);
        v.vertex.x -= sin(_Time.y * 0.5);
        v.vertex.y += sin(-_Time.y * 20) * dis * dis * 0.2;
    }
    
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_island4 (a2v_tree v)
{
    v2f_tree o;
    v.vertex.xyz = KeinIsland4VertAni(v.vertex.xyz,v.color.g);
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_island vert_island5 (a2v_tree v)
{
    v2f_island o;
    v.vertex.xyz = KeinIsland4VertAni(v.vertex.xyz,v.color.g);
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.unlit = v.color.b;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_island vert_island9 (a2v_tree v)
{
    v2f_island o;
    //v.vertex.xyz = KeinIsland4VertAni(v.vertex.xyz,v.color.g);
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.unlit = v.color.b;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_island9build (a2v_tree v)
{
    v2f_tree o;
    //v.vertex.xyz = KeinIsland4VertAni(v.vertex.xyz,v.color.g);
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
v2f_tree vert_island4river (a2v_tree v)
{
    v2f_tree o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
    o.worldViewDir = _WorldSpaceCameraPos.xyz - Kein_LocalToWorld(v.vertex).xyz;
    o.worldLightDir = WorldSpaceLightDir(v.vertex);
    o.uv.xy = v.uv;
    o.uv.zw = v.uv2;
    TRANSFER_SHADOW (o);
    return o;
}
#endif
