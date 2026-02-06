Shader "Kein/UI/3DText"
{
    Properties
    {
        _Color("Text Color", Color) = (1,1,1,1)
        _MainTex("Font Texture", 2D) = "white" {}
        _IsText("IsText",float) = 1
    }
        SubShader
        {
            Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }

            Pass
            {
                ZWrite On
                ColorMask 0
            }

            Pass
            {
                Blend SrcAlpha OneMinusSrcAlpha
                //ZWrite On
                Cull Off
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                struct appdata
                {
                    float4 vertex : POSITION;
                    fixed4 color : COLOR;
                    float2 uv : TEXCOORD0;
                };
                struct v2f
                {
                    float2 uv : TEXCOORD0;
                    fixed4 color : COLOR;
                    float4 vertex : SV_POSITION;
                };
                float _IsText;
                sampler2D _MainTex;
                fixed4 _Color;
                v2f vert(appdata v)
                {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = v.uv;
                    o.color = v.color;
                    return o;
                }
                fixed4 frag(v2f i) : SV_Target
                {
                    fixed4 col = tex2D(_MainTex, i.uv);
                    col.a = col.a * _Color.a * i.color.a;

                col.rgb = _IsText > 0.5 ? _Color.rgb : col.rgb * _Color.rgb * i.color;
                //col *= i.color;

                return col;
            }
            ENDCG
        }

        }
}
