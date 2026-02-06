#ifndef KEIN_METHOD
#define KEIN_METHOD

// Common
inline float Kein_RandomValue(float2 uv)
{
    return frac(sin(dot(uv, float2(12.9898, 76.154))) * 45359.6543);
}

// Vert
float4 Kein_LocalToWorld(float4 _vertex)
{
    return mul(unity_ObjectToWorld,_vertex);
}
float4 Kein_WorldToLocal(float4 _vertex)
{
    return float4(mul(unity_WorldToObject, _vertex));
}
fixed3 Kein_WorldNormal(float3 v_normal)
{
    return UnityObjectToWorldNormal(v_normal);
    // return normalize(UnityObjectToWorldNormal(v_normal));
    // mul(v_normal, (float3x3)unity_WorldToObject)
}
float4 Kein_VP(float4 _vertex) 
{
    return float4( mul(UNITY_MATRIX_VP, _vertex) );
}
float4 Kein_MVP(float4 _vertex)
{
    return float4(UnityObjectToClipPos(_vertex));
}
float3 Kein_CameraPos()
{
    return _WorldSpaceCameraPos.xyz;
}
float2 Kein_MatCapUV(float3 _normal)
{
    float2 matCapUV;
    matCapUV.x = dot(normalize(UNITY_MATRIX_IT_MV[0].xyz), normalize(_normal));
    matCapUV.y = dot(normalize(UNITY_MATRIX_IT_MV[1].xyz), normalize(_normal));
    matCapUV = matCapUV * 0.5 + 0.5;
    return matCapUV;
}
float4x4 Kein_Rotation4x4(float3 _rotation) // 旋转矩阵
{
    float radX = radians(_rotation.x);
    float radY = radians(_rotation.y);
    float radZ = radians(_rotation.z);

    float sinX = sin(radX);
    float cosX = cos(radX);
    float sinY = sin(radY);
    float cosY = cos(radY);
    float sinZ = sin(radZ);
    float cosZ = cos(radZ);

    return float4x4(
           cosY * cosZ, -cosY * sinZ, sinY, 0.0,
           cosX * sinZ + sinX * sinY * cosZ, cosX * cosZ - sinX * sinY * sinZ, -sinX * cosY, 0.0,
           sinX * sinZ - cosX * sinY * cosZ, sinX * cosZ + cosX * sinY * sinZ, cosX * cosY, 0.0,
           0.0, 0.0, 0.0, 1.0
    );
}
float4 Kein_Rotation(float3 _rotation, float4 _vertex) // 旋转
{
    return float4(mul(Kein_Rotation4x4(_rotation), _vertex));
}
float4 Kein_BookRotation(float _centerX, float _angle, float4 _vertex) // 翻书
{
    _vertex.x += _centerX; //改变旋转轴心，旋转前改变

    // Z轴旋转矩阵
    float s;
    float c;
    sincos(radians(_angle), s, c); // 同时计算 float x 的 sin 值和 cos 值
   
    // s = cos(radians(_Angle));
    // c = sin(radians(_Angle)); // 等价上面同时计算
    
    float4x4 rotation =
    {
        c, s, 0, 0,
       -s, c, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    };
    _vertex = mul(rotation, _vertex);

    _vertex.x -= _centerX; //改变旋转轴心，旋转后要恢复
    return _vertex;
}
float4 Kein_OutLine(float4 _vertex, float3 _normal, float _outLineFactor) // 描边
{
    float4 pos = UnityObjectToClipPos(_vertex);
    float3 vnormal = mul((float3x3)UNITY_MATRIX_IT_MV, _normal);   //将法线方向转换到视空间
    float2 offset = TransformViewToProjection(vnormal.xy);         //将视空间法线xy坐标转化到投影空间，只有xy需要，z深度不需要了
    pos.xy += offset * _outLineFactor;
    return pos;
}
float4 Kein_Water(float4 _vertex) // 水波纹
{
    float4 o;
    float dis = distance( _vertex.xyz, float3(0,0,0));
    float h = sin( dis * 2 + _Time.z ) / 3;
    o = Kein_LocalToWorld(_vertex);
    o.y = h;
    o = Kein_WorldToLocal(o);
    return o;
}
float4 Kein_VertexBend_Z(float4 _worldPos,float _startBend_Z = 0)
{
    float  startPos = _WorldSpaceCameraPos.z + _startBend_Z;
    float  dis = _worldPos.z - startPos;

    //if (_worldPos.z > startPos)
    //{
    //    _worldPos.y = _worldPos.y - 40 * dis * dis * 0.0001;
    //    return _worldPos;
    //}
    return _worldPos;
}
float Kein_Color_Z(float4 _worldPos,float _cameraStartPos,float _startCol_Z, float _endCol_Z = 30)
{
    float disCol;
    float disC = _worldPos.z - _WorldSpaceCameraPos.z - _cameraStartPos - _startCol_Z;
    float allC = _endCol_Z  - _startCol_Z;
    float start = _WorldSpaceCameraPos.z + 7 + _startCol_Z;
    
    disCol = disC / allC;
    
    return disCol;
}
float Kein_Color_X(float4 _worldPos,float _startCol_x, float _endCol_x)
{
    float disCol;
    float disC = abs(_worldPos.x - _WorldSpaceCameraPos.x)  - _startCol_x;
    float allC = _endCol_x  - _startCol_x;
    float start = _WorldSpaceCameraPos.x + _startCol_x;
    
    disCol = disC / allC;
    
    return disCol;
}
float Kein_Color_Y(float4 _worldPos, float _endCol_y)
{
    float disCol;
    float disC = _worldPos.y;
    float allC = _endCol_y;
    disCol = abs(disC / allC);
    return disCol;
}
float Kein_DisCol_1(float4 _worldPos,float _fogDensity )
{ 
     float dis = Kein_Color_Z(_worldPos,7,40,4 * _fogDensity);
     dis = dis <= 0 ? 0 : dis;
     return dis;
}
float Kein_DisCol_2(float4 _worldPos,float _fogDensity )
{ 
     float dis = Kein_Color_Z(_worldPos,10,30,2.5 * _fogDensity);
     dis = dis <= 0 ? 0 : dis;
     return dis;
}

// Frag
float3 Kein_RGBToHSV(float3 c)
{
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
    float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
    float d = q.x - min( q.w, q.y );
    float e = 1.0e-10;
    return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
float3 Kein_HSVToRGB( float3 c )
{
    float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
    float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
    return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
}
float4 Kein_RGBtoHSL(float4 rgb)
{
    float r = rgb.r;
    float g = rgb.g;
    float b = rgb.b;
    
    float maxComponent = max(max(r, g), b);
    float minComponent = min(min(r, g), b);
    float h = 0.0;
    float s = 0.0;
    float l = (maxComponent + minComponent) / 2.0;
    
    if (maxComponent != minComponent)
    {
        float d = maxComponent - minComponent;
        s = l > 0.5 ? d / (2.0 - maxComponent - minComponent) : d / (maxComponent + minComponent);
        
        if (maxComponent == r)
        {
            h = (g - b) / d + (g < b ? 6.0 : 0.0);
        }
        else if (maxComponent == g)
        {
            h = (b - r) / d + 2.0;
        }
        else if (maxComponent == b)
        {
            h = (r - g) / d + 4.0;
        }
            
        h /= 6.0;
    }
    return float4(h, s, l, rgb.a);
}
float3 Kein_HSLtoRGB(float4 hsl)
{
    float h = hsl.x;
    float s = hsl.y;
    float l = hsl.z;
    
    if (s == 0)
    {
        return float3(l, l, l);
    }
    
    float q = l < 0.5 ? l * (1.0 + s) : l + s - l * s;
    float p = 2.0 * l - q;
    
    float3 rgb = float3(h + 1.0 / 3.0, h, h - 1.0 / 3.0);
    
    for (int i = 0; i < 3; i++)
    {
        if (rgb[i] < 0)
        {
            rgb[i] += 1.0;
        }
        else if (rgb[i] > 1)
        {
             rgb[i] -= 1.0;
        }
        
        if (rgb[i] < 1.0 / 6.0)
        {
            rgb[i] = p + (q - p) * 6.0 * rgb[i];
        }
        else if (rgb[i] < 0.5)
        {
            rgb[i] = q;
        }
        else if (rgb[i] < 2.0 / 3.0)
        {
            rgb[i] = p + (q - p) * 6.0 * (2.0 / 3.0 - rgb[i]);
        }
        else
        {
            rgb[i] = p;
        }
    }
    
    return rgb;
}

float2 Kein_UVCenter()    // UV 中心点
{
    return float2(0.5,0.5);
}
half2 Kein_UV_CenterScale(half2 _uv, float _scale)  // UV 基于中心缩放
{
    return (_uv - Kein_UVCenter()) / _scale + Kein_UVCenter();
}
float3x3 Kein_Scale2d(float2 scale)
{
                //缩放矩阵作用于坐标系，所以放大和缩小刚好相反，为了使用习惯，缩放参数取倒数
    return float3x3(1.0 / scale.x, 0.0, 0.0,
                    0.0, 1.0 / scale.y, 0.0,
                    0.0, 0.0, 1.0
    );
}
float2 Kein_UVRotation(float2 _uv, float _angle) // UV 旋转
{
    float2 uv = float2(0,0);                             // 定义旋转之后的uv
    _uv -= float2(0.5, 0.5);                             // uv旋转中心点居中
    //if (length(i.uv) > 0.5)                            // 对旋转超出去的地方做处理
    //{
    //    return fixed4(0, 0, 0, 0);                     // 超出去的地方返回颜色0，0，0，0
    //}
    uv.x = _uv.x * cos(_angle) + _uv.y * sin(_angle);    // 计算uv旋转后x的坐标（三角函数）
    uv.y = _uv.y * cos(_angle) - _uv.x * sin(_angle);    // 计算uv旋转后y的坐标（三角函数）
    uv += float2(0.5, 0.5);                              // 旋转后的uv坐标居中
    return uv;
}
float3 Kein_Fog(fixed4 _color, float _fogDensity) // 模拟雾
{
    return lerp(_color.rgb,_color.rgb * 0.5, _fogDensity);
}
fixed3 KeinRimCol(float3 wNormal,float3 wViewDir,fixed3 rimCol,float intensity,float power) // 边缘光
{
    fixed3 worldNormal = normalize(wNormal);
    float3 worldViewDir = normalize(wViewDir);
    float rim = 1 - max(0, dot(worldViewDir, worldNormal));
    fixed3 rimColor = rimCol * pow(rim * intensity, power);
    return rimColor;
}
fixed3 Kein_GrayColor(fixed3 _col) // 置灰
{
    return dot(_col, float3(0.299, 0.587, 0.114));
}
float2 Kein_Sequence(float2 _uv, float _horizontalAmount, float _verticalAmount, float _speed = 10) // 序列帧
{
    float time = floor(_Time.y * _speed);          // floor ：向下取整
    float row = floor(time / _horizontalAmount);   // 行索引值
    float column = time - row * _horizontalAmount; // 列索引值

    half2 uv = float2(_uv.x / _horizontalAmount, _uv.y / _verticalAmount);
    uv.x += column / _horizontalAmount;
    uv.y -= row / _verticalAmount;

    //等价
    //half2 uv = _uv + half2(column, -row);
    //uv.x /= _horizontalAmount;
    //uv.y /= _verticalAmount;
    return uv;
}
fixed3 Kein_EdgeGlow(fixed3 _col, fixed4 _glowColor, float _glowStrength) // 纹理边缘光
{
    fixed edge = fwidth(_col) * _glowStrength;  // fwidth() 计算函数在屏幕空间中的每个像素上的变化率
    fixed3 glow = _glowColor.rgb * edge;
    _col += glow;
    return _col;
}
float4 Kein_Mistake(fixed4 _col, fixed4 _col1, fixed4 _col2) // 扰乱
{
    float4 timeCol = _Time;
    //主纹理的颜色值+从颜色1到颜色2，波动效果   rgb颜色，lerp线性插值 sin波动效果
    float3 emissive = (_col.rgb + lerp(_col1.rgb, _col2.rgb, (sin((timeCol.g * 25.0)) * 0.5 + 0.5)));
    return float4(emissive, _col.a);
}
float2 Kein_TwistDisplaceUV(sampler2D _distortionTex, float2 _uv, float _amount, float _speed) // 置换扭曲
{
    float4 dist = tex2D(_distortionTex,_uv); // 获取置换纹理的偏移量，以及纹理的颜色值
    float offset = (dist.r - 0.5) * _amount;

    // 计算置换后的纹理坐标
    float2 displacedUv = _uv + float2(offset * _speed, 0);
    return displacedUv;
}
inline float Kein_NoiseValue(float2 _uv)
{
    float2 i = floor(_uv);  // 向下取整
    float2 f = frac(_uv);   // 取小数
    f = f * f * (3 - 2 * f);

    float2 a1 = i + float2(0, 0);
    float2 a2 = i + float2(1, 0);
    float2 a3 = i + float2(0, 1);
    float2 a4 = i + float2(1, 1);

    float b1 = Kein_RandomValue(a1);
    float b2 = Kein_RandomValue(a2);
    float b3 = Kein_RandomValue(a3);
    float b4 = Kein_RandomValue(a4);

    //平滑处理
    float L1 = lerp(b1, b2, f.x);
    float L2 = lerp(b3, b4, f.x);
    float Out = lerp(L1, L2, f.y);

    return Out;
}
inline float Kein_SimpleNoise(float2 _uv, float _scale)
{
    float t = 0;
    float freq;
    float pows;

    freq = pow(2, 0);
    pows = pow(0.5, 3);

    t += Kein_NoiseValue(float2(_uv.x * _scale / freq, _uv.y * _scale / freq)) * pows;

    freq = pow(2, 1);
    pows = pow(0.5, 2);

    t += Kein_NoiseValue(float2(_uv.x * _scale / freq, _uv.y * _scale / freq)) * pows;

    freq = pow(2, 2);
    pows = pow(0.5, 1);

    t += Kein_NoiseValue(float2(_uv.x * _scale / freq, _uv.y * _scale / freq)) * pows;

    return t;
}
inline float3 Kein_ComputeData(float3 _objPos, float3 _normalPos, float _scale, float _factor) // 音乐球球
{
    float3 UV1 = _objPos + _Time.y;
    float noiseVal = Kein_SimpleNoise(UV1.xy, _scale) * _factor;

    float3 putNormal = _normalPos * noiseVal;
    float3 Out = _objPos * putNormal;

    return Out;
}

fixed3 Kein7Color(float _intRange)
{
    if(_intRange < 1.5)
    {
        return fixed3(0.95,0.2,0.2); 
    }
    else if (_intRange < 2.5 && _intRange > 1.5)
    {
        return fixed3(0.28,0.86,0.4); 
    }
    else if (_intRange < 3.5 && _intRange > 2.5)
    {
        return fixed3(0.2,0.4,0.95); 
    }
    else if (_intRange < 4.5 && _intRange > 3.5)
    {
        return fixed3(0.95,0.69,0.2); 
    }
    else if (_intRange < 5.5 && _intRange > 4.5)
    {
        return fixed3(0.95,0.2,0.71); 
    }
    else if (_intRange < 6.5 && _intRange > 5.5)
    {
        return fixed3(0.2,0.95,0.95); 
    }
    else if (_intRange < 7.5 && _intRange > 6.5)
    {
        return fixed3(0.82,0.82,0.82); 
    }
    else
    {
        return fixed3(0.31,0.31,0.31); 
    }
}

float3 KeinIsland4VertAni(float3 _vertex, fixed _vColorG)
{
    if(_vColorG < 0.9f)
    {
        float disw = distance(_vertex, float3(0,0,0));
        float dis = _vertex.y;

        _vertex.x -= (sin(_Time.y + _vColorG * 2) + sin(_Time.y * disw * 0.02) * 0.5) * dis * dis * 0.003f;
        _vertex.y += (sin(_Time.y + _vColorG * 2) + sin(-_Time.y * disw * 0.02) * 0.5) * dis * dis * 0.003f;
        _vertex.z -= (sin(-_Time.y + _vColorG * 2) + cos(-_Time.y * disw * 0.02) * 0.5) * dis * dis * 0.003f;
    }
    return _vertex;
}


#endif
