//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "HyperShaderNoSpecular" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ShadowStrength ("Shadow Strength", Range(0, 1)) = 0.4
_Diffuse ("_Diffuse", Color) = (1,1,1,1)
_SelfShadowColor ("_SelfShadowColor", Color) = (1,1,1,1)
_Falloff ("_Falloff", Range(0, 1)) = 0
_FalloffPower ("_Falloff Power", Float) = 1
_FalloffColor ("Falloff Color", Color) = (1,1,1,1)
_Alpha ("Alpha", Float) = 1
_SlowMotionDependence ("SlowMotionDependence", Range(0, 1)) = 1
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" }
  GpuProgramID 48208
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0 = max(u_xlat0, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0 * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0 = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
float u_xlat3;
float u_xlat9;
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
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _Falloff;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FalloffPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 * _SelfShadowColor.w;
    u_xlat1.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat1.xyz = vec3(u_xlat3) * u_xlat1.xyz + _Diffuse.xyz;
    u_xlat1.w = 1.0;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat3 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat3) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
void main()
{
    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb0 = vs_TEXCOORD1.z<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Diffuse;
uniform 	mediump vec4 _SelfShadowColor;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _FalloffColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * _Falloff;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _FalloffPower;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _SelfShadowColor.w;
    u_xlat2.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = u_xlat1.xxxx * u_xlat3 + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 _LightShadowData;
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	float _ShadowStrength;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
void main()
{
    vec3 txVec0 = vec3(vs_TEXCOORD1.xy,vs_TEXCOORD1.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_1.x = (-_LightShadowData.x) + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _LightShadowData.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = (-u_xlat16_1.x) * _ShadowStrength + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat16_1.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.w = _Alpha;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "VertexLit"
}