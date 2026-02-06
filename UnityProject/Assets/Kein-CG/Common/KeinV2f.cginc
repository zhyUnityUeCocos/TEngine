#ifndef KEIN_V2F
#define KEIN_V2F
// 顶点      float4 vertex : SV_POSITION;
// UV        float2 uv : TEXCOORD0;
// 雾效      UNITY_FOG_COORDS(1)
// 阴影      SHADOW_COORDS(2)
// rim       float3 worldViewDir : TEXCOORD1;   float3 worldNormal : TEXCOORD2;
// matCap    matCap : TEXCOORD3;
struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
};
struct v2f_uv4
{
    float4 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
};
struct v2f_color
{
    float2 uv : TEXCOORD0;
    fixed4 color : COLOR;
    float4 vertex : SV_POSITION;
};
struct v2f_rim
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
};
struct v2f_rim4
{
    float4 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
};
struct v2f_rim_matCap
{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
    float2 matCap : TEXCOORD3;
};
struct v2f_rim_dis
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
    float disZ : TEXCOORD3;
};
struct v2f_Shadow
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    SHADOW_COORDS(1)
};
struct v2f_gameBg
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    SHADOW_COORDS(1)
};
struct v2f_block
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
    float3 worldLightDir : TEXCOORD3;
    float3 worldPos:TEXCOORD4;
    SHADOW_COORDS(5)
};
struct v2f_tree
{
    float4 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
    float3 worldLightDir : TEXCOORD3;
    SHADOW_COORDS(4)
};
struct v2f_island
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldViewDir : TEXCOORD1;
    float3 worldNormal : TEXCOORD2;
    float3 worldLightDir : TEXCOORD3;
    float unlit : TEXCOORD4;
    SHADOW_COORDS(5)
};
#endif


