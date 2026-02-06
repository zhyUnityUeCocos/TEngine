#ifndef KEIN_FRAG_UNLIT
#define KEIN_FRAG_UNLIT
fixed4 frag (v2f i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv);
    return col;
}
fixed4 frag_TwoCol(v2f i) : COLOR
{
    fixed3 Col = lerp(_Color2,_Color1,i.uv.y);
    return fixed4(Col,1);
}
fixed4 frag_water (v2f i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
    col.a = lerp(0,col.a,i.uv.y);
    return col;
}
fixed4 frag_BlockTrail (v2f_color i) : SV_Target
{
    fixed4 col = tex2D(_MainTex, i.uv) * i.color;
    return col;
}
fixed4 frag_island1_water (v2f_island1_water i) : SV_Target
{
    float2 uv = i.uv;
    float uva = i.uv.y;
    //uv.y += sin(i.dis * 2 + _Time.y) * 0.05;
    uv.x += sin(i.dis * 1 + _Time.y) * 0.01;
    fixed4 col = tex2D(_MainTex, uv) * _Color;
    //fixed3 waterCol = fixed3(0.22,0.56,0.66);
    //fixed3 boWenCol = fixed3(0.61,1,0.95);
    //waterCol = col.r > 0.5 ? boWenCol : waterCol;
    //uva = uva * 3 > 1 ? 1 : uva * 3;
    //fixed a = lerp(0,1,uva);
    //return fixed4(waterCol,a);

    return _Color;

}
#endif


