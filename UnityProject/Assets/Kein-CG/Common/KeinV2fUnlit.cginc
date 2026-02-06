#ifndef KEIN_V2F_UNLIT
#define KEIN_V2F_UNLIT

// Common
struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
};
struct v2f_color
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    fixed4 color : COLOR;
};
// 顶点      float4 vertex : SV_POSITION;
// UV        float2 uv : TEXCOORD0;
// 雾效      UNITY_FOG_COORDS(1)
// 阴影      SHADOW_COORDS(2)

// rim       float3 worldViewDir : TEXCOORD1;   float3 worldNormal : TEXCOORD2;
// matCap    matCap : TEXCOORD3;
struct v2f_island1_water
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float dis : TEXCOORD1;
};

#endif


