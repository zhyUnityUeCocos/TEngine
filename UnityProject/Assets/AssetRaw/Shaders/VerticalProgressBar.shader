Shader "UI/VerticalProgressBarWithMask"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Progress ("Progress", Range(0,1)) = 0.5
        _Border ("Border", Vector) = (0,0,0,0)
        _ClipRect ("Clip Rect", vector) = (-32767, -32767, 32767, 32767)
        // Mask Support
        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 1
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
        // Mask Support End
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        Cull Off

        Pass
        {
            // Step 1: Stencil Masking
            Stencil
            {
                Ref [_Stencil]
                Comp [_StencilComp]
                Pass [_StencilOp]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
            }
            ColorMask [_ColorMask]

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
                #ifdef UNITY_UI_CLIP_RECT
                float4 worldPosition : TEXCOORD1;
                #endif
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Progress;
            float4 _Border;
            uniform float4 _ClipRect;

            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.color = v.color;
                #ifdef UNITY_UI_CLIP_RECT
                o.worldPosition = v.vertex;
                #endif
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Step 2: Check if pixel is within Stencil Mask
                #ifdef UNITY_UI_CLIP_RECT
                if (i.worldPosition.x < _ClipRect.x || i.worldPosition.x > _ClipRect.z ||
                    i.worldPosition.y < _ClipRect.y || i.worldPosition.y > _ClipRect.w)
                    discard;
                #endif

                // 获取进度条上下边界
                float minY = _Border.y; 
                float maxY = 1.0 - _Border.w;
                float fillY = lerp(minY, maxY, _Progress);
                if(_Progress < 0.001f) fillY = 0;               
                // Step 3: Combine Stencil Masking and Progress
                // 如果纹理坐标y值小于填充y值，表示进度条需要填充的部分
                if (i.uv.y < fillY)
                {
                    fixed4 texColor = tex2D(_MainTex, i.uv) * i.color;                  
                    return texColor;
                }
                
                return fixed4(0,0,0,0); // 否则返回透明
            }
            ENDCG
        }
    }
}
