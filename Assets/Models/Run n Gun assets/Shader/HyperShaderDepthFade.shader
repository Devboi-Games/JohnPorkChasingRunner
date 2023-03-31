//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "HyperShaderDepthFade" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ShadowStrength ("Shadow Strength", Range(0, 1)) = 0.4
_Diffuse ("_Diffuse", Color) = (1,1,1,1)
_SelfShadowColor ("_SelfShadowColor", Color) = (1,1,1,1)
_SpecularColor ("_SpecularColor", Color) = (1,1,1,1)
_Glossiness ("_Glossiness", Float) = 0.5
_Falloff ("_Falloff", Range(0, 1)) = 0
_FalloffPower ("_Falloff Power", Float) = 1
_FalloffColor ("Falloff Color", Color) = (1,1,1,1)
_Alpha ("Alpha", Range(0, 1)) = 1
_SlowMotionDependence ("SlowMotionDependence", Range(0, 1)) = 1
_FadeNear ("FadeNear", Range(0, 1)) = 1
}
SubShader {
 Pass {
  Name "Caster"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
  GpuProgramID 51846
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" }
  GpuProgramID 129910
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat13;
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
    u_xlat1.x = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _SlowMotionNoiseAmplitude;
    u_xlat5.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat1.x * u_xlat5.x + u_xlat0.y;
    gl_Position.xzw = u_xlat0.xzw;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat1.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x * _Falloff;
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _FalloffPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat8 = (-u_xlat5.x) + 1.0;
    u_xlat8 = u_xlat8 * _SelfShadowColor.w;
    u_xlat5.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat5.xyz + _Diffuse.xyz;
    u_xlat2.w = 1.0;
    u_xlat1 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    u_xlat1 = u_xlat4.xxxx * u_xlat2 + u_xlat1;
    u_xlat0.x = u_xlat0.x + (-u_xlat1.w);
    vs_COLOR0.w = _FadeNear * u_xlat0.x + u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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
uniform 	mediump vec4 _SpecularColor;
uniform 	float _Glossiness;
uniform 	float _Falloff;
uniform 	float _FalloffPower;
uniform 	float _SlowMotionDependence;
uniform 	float _FadeNear;
uniform 	float _SlowMotion;
uniform 	float _SlowMotionNoisePeriod;
uniform 	float _SlowMotionNoiseAmplitude;
uniform 	float _SlowMotionNoiseTime;
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
vec3 u_xlat4;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat11;
float u_xlat17;
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
    u_xlat2.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoisePeriod + _SlowMotionNoiseTime;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _SlowMotionNoiseAmplitude;
    u_xlat7.x = _SlowMotionDependence * _SlowMotion;
    gl_Position.y = u_xlat2.x * u_xlat7.x + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
    vs_TEXCOORD2 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat2.xyz = _WorldSpaceLightPos0.xyz * u_xlat16_3.xxx + u_xlat6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat4.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat17 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Glossiness;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat6.xyz);
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat6.x * _Falloff;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _FalloffPower;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat11 = (-u_xlat7.x) + 1.0;
    u_xlat11 = u_xlat11 * _SelfShadowColor.w;
    u_xlat7.xyz = _Diffuse.xyz * _SelfShadowColor.xyz + (-_Diffuse.xyz);
    u_xlat3.xyz = vec3(u_xlat11) * u_xlat7.xyz + _Diffuse.xyz;
    u_xlat3.w = 1.0;
    u_xlat2 = u_xlat2.xxxx * _SpecularColor + u_xlat3;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    u_xlat2 = u_xlat6.xxxx * u_xlat3 + u_xlat2;
    u_xlat1.x = u_xlat1.x + (-u_xlat2.w);
    vs_COLOR0.w = _FadeNear * u_xlat1.x + u_xlat2.w;
    vs_COLOR0.xyz = u_xlat2.xyz;
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
    SV_Target0.w = vs_COLOR0.w * _Alpha;
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