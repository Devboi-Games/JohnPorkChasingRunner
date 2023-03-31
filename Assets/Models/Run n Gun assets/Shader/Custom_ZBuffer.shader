//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/ZBuffer" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ForceBlur ("ForceBlur", Range(0.1, 10)) = 1
_CameraNear ("CameraNear", Range(0.1, 300)) = 0.1
_CameraFar ("CameraFar", Range(0.1, 300)) = 300
_Min ("Min", Range(0.1, 50)) = 0.1
_Max ("Max", Range(0.1, 50)) = 30
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 2489
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _CameraNear;
uniform 	float _CameraFar;
uniform 	float _Min;
uniform 	float _Max;
uniform 	float _ForceBlur;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
lowp vec4 u_xlat10_6;
vec2 u_xlat7;
vec2 u_xlat14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = (-_CameraNear) + _CameraFar;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _CameraNear;
    u_xlat0.x = u_xlat0.x + (-_Min);
    u_xlat7.x = (-_Min) + _Max;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1.y = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(0.0);
    u_xlat7.xy = u_xlat1.xy * vec2(vec2(_ForceBlur, _ForceBlur));
    u_xlat0.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat14.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD1.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat10_0 = texture2D(_MainTex, u_xlat14.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD1.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD1.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD1.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_6 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4 = texture2D(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat10_3 + u_xlat10_6;
    u_xlat2 = u_xlat10_2 + u_xlat3;
    u_xlat10_3 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat10_5 = texture2D(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat2 = u_xlat10_4 + u_xlat2;
    u_xlat0 = u_xlat10_0 + u_xlat2;
    u_xlat0 = u_xlat10_5 + u_xlat0;
    u_xlat0 = u_xlat10_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _CameraNear;
uniform 	float _CameraFar;
uniform 	float _Min;
uniform 	float _Max;
uniform 	float _ForceBlur;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
lowp vec4 u_xlat10_6;
vec2 u_xlat7;
vec2 u_xlat14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = (-_CameraNear) + _CameraFar;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _CameraNear;
    u_xlat0.x = u_xlat0.x + (-_Min);
    u_xlat7.x = (-_Min) + _Max;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1.y = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(0.0);
    u_xlat7.xy = u_xlat1.xy * vec2(vec2(_ForceBlur, _ForceBlur));
    u_xlat0.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat14.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD1.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat10_0 = texture2D(_MainTex, u_xlat14.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD1.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD1.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD1.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_6 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4 = texture2D(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat10_3 + u_xlat10_6;
    u_xlat2 = u_xlat10_2 + u_xlat3;
    u_xlat10_3 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat10_5 = texture2D(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat2 = u_xlat10_4 + u_xlat2;
    u_xlat0 = u_xlat10_0 + u_xlat2;
    u_xlat0 = u_xlat10_5 + u_xlat0;
    u_xlat0 = u_xlat10_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _CameraNear;
uniform 	float _CameraFar;
uniform 	float _Min;
uniform 	float _Max;
uniform 	float _ForceBlur;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
lowp vec4 u_xlat10_6;
vec2 u_xlat7;
vec2 u_xlat14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = (-_CameraNear) + _CameraFar;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _CameraNear;
    u_xlat0.x = u_xlat0.x + (-_Min);
    u_xlat7.x = (-_Min) + _Max;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1.y = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(0.0);
    u_xlat7.xy = u_xlat1.xy * vec2(vec2(_ForceBlur, _ForceBlur));
    u_xlat0.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat14.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD1.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat10_0 = texture2D(_MainTex, u_xlat14.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD1.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD1.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD1.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD1.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_6 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4 = texture2D(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat10_3 + u_xlat10_6;
    u_xlat2 = u_xlat10_2 + u_xlat3;
    u_xlat10_3 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat10_5 = texture2D(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat2 = u_xlat10_4 + u_xlat2;
    u_xlat0 = u_xlat10_0 + u_xlat2;
    u_xlat0 = u_xlat10_5 + u_xlat0;
    u_xlat0 = u_xlat10_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _CameraNear;
uniform 	float _CameraFar;
uniform 	float _Min;
uniform 	float _Max;
uniform 	float _ForceBlur;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
vec2 u_xlat7;
vec2 u_xlat14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = (-_CameraNear) + _CameraFar;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _CameraNear;
    u_xlat0.x = u_xlat0.x + (-_Min);
    u_xlat7.x = (-_Min) + _Max;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.y = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(0.0);
    u_xlat7.xy = u_xlat1.xy * vec2(vec2(_ForceBlur, _ForceBlur));
    u_xlat0.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat14.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD1.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat16_0 = texture(_MainTex, u_xlat14.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD1.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD1.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD1.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_6 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4 = texture(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat16_3 + u_xlat16_6;
    u_xlat2 = u_xlat16_2 + u_xlat3;
    u_xlat16_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5 = texture(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat2 = u_xlat16_4 + u_xlat2;
    u_xlat0 = u_xlat16_0 + u_xlat2;
    u_xlat0 = u_xlat16_5 + u_xlat0;
    u_xlat0 = u_xlat16_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _CameraNear;
uniform 	float _CameraFar;
uniform 	float _Min;
uniform 	float _Max;
uniform 	float _ForceBlur;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
vec2 u_xlat7;
vec2 u_xlat14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = (-_CameraNear) + _CameraFar;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _CameraNear;
    u_xlat0.x = u_xlat0.x + (-_Min);
    u_xlat7.x = (-_Min) + _Max;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.y = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(0.0);
    u_xlat7.xy = u_xlat1.xy * vec2(vec2(_ForceBlur, _ForceBlur));
    u_xlat0.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat14.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD1.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat16_0 = texture(_MainTex, u_xlat14.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD1.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD1.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD1.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_6 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4 = texture(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat16_3 + u_xlat16_6;
    u_xlat2 = u_xlat16_2 + u_xlat3;
    u_xlat16_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5 = texture(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat2 = u_xlat16_4 + u_xlat2;
    u_xlat0 = u_xlat16_0 + u_xlat2;
    u_xlat0 = u_xlat16_5 + u_xlat0;
    u_xlat0 = u_xlat16_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _CameraNear;
uniform 	float _CameraFar;
uniform 	float _Min;
uniform 	float _Max;
uniform 	float _ForceBlur;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
vec2 u_xlat7;
vec2 u_xlat14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7.x = (-_CameraNear) + _CameraFar;
    u_xlat0.x = u_xlat0.x * u_xlat7.x + _CameraNear;
    u_xlat0.x = u_xlat0.x + (-_Min);
    u_xlat7.x = (-_Min) + _Max;
    u_xlat0.x = u_xlat0.x / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.y = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(0.0);
    u_xlat7.xy = u_xlat1.xy * vec2(vec2(_ForceBlur, _ForceBlur));
    u_xlat0.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat14.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD1.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat16_0 = texture(_MainTex, u_xlat14.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD1.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD1.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD1.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD1.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_6 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4 = texture(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat16_3 + u_xlat16_6;
    u_xlat2 = u_xlat16_2 + u_xlat3;
    u_xlat16_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5 = texture(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat2 = u_xlat16_4 + u_xlat2;
    u_xlat0 = u_xlat16_0 + u_xlat2;
    u_xlat0 = u_xlat16_5 + u_xlat0;
    u_xlat0 = u_xlat16_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
}
}