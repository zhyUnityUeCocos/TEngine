#ifndef KEIN_A2V
#define KEIN_A2V

// 基础
struct a2v
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};
struct a2v_color
{
    float4 vertex : POSITION;
    fixed4 color : COLOR;
    float2 uv : TEXCOORD0;
};
struct a2v_normal
{
    float4 vertex : POSITION;
    float3 normal:NORMAL;
    float2 uv : TEXCOORD0;
};

// HS
struct a2v_tree
{
    float4 vertex : POSITION;
    float3 normal:NORMAL;
    fixed4 color : COLOR;
    float2 uv : TEXCOORD0;
    float2 uv2 : TEXCOORD1;
};

#endif


