//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/BlurShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Mask ("Mask", 2D) = "White" { }
_BlurBlockSize ("BlurBlockSize", Range(0.2, 10)) = 1
_BlurColorPow ("BlurColorPow", Range(0, 1)) = 1
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 55207
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _BlurColorPow;
uniform 	float _BlurBlockSize;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _SlowMotion;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
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
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat0.y = u_xlat0.x * _BlurBlockSize;
    u_xlat0.x = _BlurBlockSize;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat1.w = 0.0;
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_6 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4 = texture2D(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat10_3 + u_xlat10_6;
    u_xlat2 = u_xlat10_2 + u_xlat3;
    u_xlat10_3 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat10_5 = texture2D(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat2 = u_xlat10_4 + u_xlat2;
    u_xlat0 = u_xlat10_0 + u_xlat2;
    u_xlat0 = u_xlat10_5 + u_xlat0;
    u_xlat0 = u_xlat10_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    u_xlat1 = u_xlat0 * u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat0 + (-u_xlat0);
    u_xlat0 = vec4(_BlurColorPow) * u_xlat1 + u_xlat0;
    u_xlat0 = (-u_xlat10_3) + u_xlat0;
    u_xlat10_1.x = texture2D(_Mask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat10_1.x * _SlowMotion;
    SV_Target0 = u_xlat1.xxxx * u_xlat0 + u_xlat10_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _BlurColorPow;
uniform 	float _BlurBlockSize;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _SlowMotion;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
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
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat0.y = u_xlat0.x * _BlurBlockSize;
    u_xlat0.x = _BlurBlockSize;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat1.w = 0.0;
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_6 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4 = texture2D(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat10_3 + u_xlat10_6;
    u_xlat2 = u_xlat10_2 + u_xlat3;
    u_xlat10_3 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat10_5 = texture2D(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat2 = u_xlat10_4 + u_xlat2;
    u_xlat0 = u_xlat10_0 + u_xlat2;
    u_xlat0 = u_xlat10_5 + u_xlat0;
    u_xlat0 = u_xlat10_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    u_xlat1 = u_xlat0 * u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat0 + (-u_xlat0);
    u_xlat0 = vec4(_BlurColorPow) * u_xlat1 + u_xlat0;
    u_xlat0 = (-u_xlat10_3) + u_xlat0;
    u_xlat10_1.x = texture2D(_Mask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat10_1.x * _SlowMotion;
    SV_Target0 = u_xlat1.xxxx * u_xlat0 + u_xlat10_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _BlurColorPow;
uniform 	float _BlurBlockSize;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _SlowMotion;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
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
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat0.y = u_xlat0.x * _BlurBlockSize;
    u_xlat0.x = _BlurBlockSize;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat1.w = 0.0;
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_6 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4 = texture2D(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat10_3 + u_xlat10_6;
    u_xlat2 = u_xlat10_2 + u_xlat3;
    u_xlat10_3 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat10_5 = texture2D(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + u_xlat10_3;
    u_xlat2 = u_xlat10_4 + u_xlat2;
    u_xlat0 = u_xlat10_0 + u_xlat2;
    u_xlat0 = u_xlat10_5 + u_xlat0;
    u_xlat0 = u_xlat10_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    u_xlat1 = u_xlat0 * u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat0 + (-u_xlat0);
    u_xlat0 = vec4(_BlurColorPow) * u_xlat1 + u_xlat0;
    u_xlat0 = (-u_xlat10_3) + u_xlat0;
    u_xlat10_1.x = texture2D(_Mask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat10_1.x * _SlowMotion;
    SV_Target0 = u_xlat1.xxxx * u_xlat0 + u_xlat10_3;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _BlurColorPow;
uniform 	float _BlurBlockSize;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _SlowMotion;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Mask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
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
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat0.y = u_xlat0.x * _BlurBlockSize;
    u_xlat0.x = _BlurBlockSize;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD0.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat1.w = 0.0;
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_6 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4 = texture(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat16_3 + u_xlat16_6;
    u_xlat2 = u_xlat16_2 + u_xlat3;
    u_xlat16_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5 = texture(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat2 = u_xlat16_4 + u_xlat2;
    u_xlat0 = u_xlat16_0 + u_xlat2;
    u_xlat0 = u_xlat16_5 + u_xlat0;
    u_xlat0 = u_xlat16_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    u_xlat1 = u_xlat0 * u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat0 + (-u_xlat0);
    u_xlat0 = vec4(_BlurColorPow) * u_xlat1 + u_xlat0;
    u_xlat0 = (-u_xlat16_3) + u_xlat0;
    u_xlat16_1.x = texture(_Mask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat16_1.x * _SlowMotion;
    SV_Target0 = u_xlat1.xxxx * u_xlat0 + u_xlat16_3;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _BlurColorPow;
uniform 	float _BlurBlockSize;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _SlowMotion;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Mask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
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
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat0.y = u_xlat0.x * _BlurBlockSize;
    u_xlat0.x = _BlurBlockSize;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD0.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat1.w = 0.0;
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_6 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4 = texture(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat16_3 + u_xlat16_6;
    u_xlat2 = u_xlat16_2 + u_xlat3;
    u_xlat16_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5 = texture(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat2 = u_xlat16_4 + u_xlat2;
    u_xlat0 = u_xlat16_0 + u_xlat2;
    u_xlat0 = u_xlat16_5 + u_xlat0;
    u_xlat0 = u_xlat16_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    u_xlat1 = u_xlat0 * u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat0 + (-u_xlat0);
    u_xlat0 = vec4(_BlurColorPow) * u_xlat1 + u_xlat0;
    u_xlat0 = (-u_xlat16_3) + u_xlat0;
    u_xlat16_1.x = texture(_Mask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat16_1.x * _SlowMotion;
    SV_Target0 = u_xlat1.xxxx * u_xlat0 + u_xlat16_3;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _BlurColorPow;
uniform 	float _BlurBlockSize;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _SlowMotion;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Mask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
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
void main()
{
    u_xlat0.x = _MainTex_TexelSize.y / _MainTex_TexelSize.x;
    u_xlat0.y = u_xlat0.x * _BlurBlockSize;
    u_xlat0.x = _BlurBlockSize;
    u_xlat1.xy = u_xlat0.xy * vec2(0.00499999989, 0.00499999989);
    u_xlat0.xy = (-u_xlat0.xy) * vec2(0.00499999989, 0.00499999989) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat2 = u_xlat1.zyxy + vs_TEXCOORD0.xyxy;
    u_xlat16_3 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2 = texture(_MainTex, u_xlat2.zw);
    u_xlat1.w = 0.0;
    u_xlat4 = u_xlat1.wyxw + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat1.xwwy * vec4(-1.0, 1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.0, -1.0) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_6 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4 = texture(_MainTex, u_xlat4.zw);
    u_xlat3 = u_xlat16_3 + u_xlat16_6;
    u_xlat2 = u_xlat16_2 + u_xlat3;
    u_xlat16_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5 = texture(_MainTex, u_xlat5.zw);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + u_xlat16_3;
    u_xlat2 = u_xlat16_4 + u_xlat2;
    u_xlat0 = u_xlat16_0 + u_xlat2;
    u_xlat0 = u_xlat16_5 + u_xlat0;
    u_xlat0 = u_xlat16_1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(0.111111, 0.111111, 0.111111, 0.111111);
    u_xlat1 = u_xlat0 * u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat0 + (-u_xlat0);
    u_xlat0 = vec4(_BlurColorPow) * u_xlat1 + u_xlat0;
    u_xlat0 = (-u_xlat16_3) + u_xlat0;
    u_xlat16_1.x = texture(_Mask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat16_1.x * _SlowMotion;
    SV_Target0 = u_xlat1.xxxx * u_xlat0 + u_xlat16_3;
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