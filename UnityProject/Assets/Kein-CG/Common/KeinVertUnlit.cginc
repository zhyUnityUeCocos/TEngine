#ifndef KEIN_VERT_UNLIT
#define KEIN_VERT_UNLIT
// 裁剪             UnityObjectToClipPos(v.vertex);
// 雾               UNITY_TRANSFER_FOG(o,o.vertex);     
// 阴影             TRANSFER_SHADOW (o);
// UV               TRANSFORM_TEX(v.uv, _MainTex);
// worldNormal      UnityObjectToWorldNormal(v.normal);
// worldNormal      mul(v.normal, (float3x3)unity_WorldToObject);
// 世界相机坐标     _WorldSpaceCameraPos.xyz
v2f vert (a2v v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    return o;
}
v2f_color vert_BlockTrail (a2v_color v)
{
    v2f_color o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    o.color = v.color;
    o.color.rgb *= Kein7Color(_RangeColor);
    return o;
}
v2f_island1_water vert_island1_water (a2v v)
{
    v2f_island1_water o;
    o.dis = distance( v.vertex.xyz, float3(0,0,0));;
    //v.vertex.y += sin(o.dis * o.dis + _Time.y ) * 0.1 + abs(sin(_Time.y *0.5 ))* 0.1;
    v.vertex.x += sin(o.dis * o.dis + _Time.y ) * 0.1 + abs(sin(_Time.y *0.5 ))* 0.1;
    v.vertex.z += sin(o.dis * o.dis + _Time.y ) * 0.1 + abs(sin(_Time.y *0.5 ))* 0.1;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    return o;
}
#endif


