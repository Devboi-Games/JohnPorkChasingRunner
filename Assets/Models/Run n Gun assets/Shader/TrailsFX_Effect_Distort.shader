//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "TrailsFX/Effect/Distort" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Cull ("Cull", Float) = 2
_AdditiveTint ("Additive Tint", Color) = (0,0,0.1,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent+101" "RenderPipeline" = "LightweightPipeline" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent+101" "RenderPipeline" = "LightweightPipeline" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 40817
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Colors;
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
uniform lowp sampler2D _CameraOpaqueTexture;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture2D(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat10_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
uniform lowp sampler2D _CameraOpaqueTexture;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture2D(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat10_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
uniform lowp sampler2D _CameraOpaqueTexture;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture2D(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat10_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _CameraOpaqueTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _CameraOpaqueTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _CameraOpaqueTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
int u_xlati4;
vec2 u_xlat8;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = vec2(0.5, 0.5) + (-PropsArray[u_xlati0]._Colors.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * PropsArray[u_xlati0]._Colors.ww;
    vs_COLOR0 = PropsArray[u_xlati0]._Colors;
    u_xlat0.xy = u_xlat16_3.xy / u_xlat1.ww;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    u_xlat8.xy = u_xlat2.zz + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat8.xy;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _CameraOpaqueTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
int u_xlati4;
vec2 u_xlat8;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = vec2(0.5, 0.5) + (-PropsArray[u_xlati0]._Colors.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * PropsArray[u_xlati0]._Colors.ww;
    vs_COLOR0 = PropsArray[u_xlati0]._Colors;
    u_xlat0.xy = u_xlat16_3.xy / u_xlat1.ww;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    u_xlat8.xy = u_xlat2.zz + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat8.xy;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _CameraOpaqueTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
int u_xlati4;
vec2 u_xlat8;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = vec2(0.5, 0.5) + (-PropsArray[u_xlati0]._Colors.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * PropsArray[u_xlati0]._Colors.ww;
    vs_COLOR0 = PropsArray[u_xlati0]._Colors;
    u_xlat0.xy = u_xlat16_3.xy / u_xlat1.ww;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    u_xlat8.xy = u_xlat2.zz + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat8.xy;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _CameraOpaqueTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_CameraOpaqueTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
}
}
}
SubShader {
 Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
 GrabPass {
  "_BackgroundTexture"
}
 Pass {
  Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 75349
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Colors;
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
uniform lowp sampler2D _BackgroundTexture;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture2D(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat10_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
uniform lowp sampler2D _BackgroundTexture;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture2D(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat10_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
uniform lowp sampler2D _BackgroundTexture;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture2D(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat10_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat10_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _BackgroundTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _BackgroundTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
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
uniform 	mediump vec4 _Colors;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
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
    u_xlat16_2.xy = (-_Colors.xy) + vec2(0.5, 0.5);
    u_xlat16_2.xy = u_xlat16_2.xy * _Colors.ww;
    u_xlat1.xy = u_xlat16_2.xy / u_xlat0.ww;
    u_xlat3.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    u_xlat0.xy = u_xlat3.zz + u_xlat3.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy + u_xlat0.xy;
    vs_COLOR0 = _Colors;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _BackgroundTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
int u_xlati4;
vec2 u_xlat8;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = vec2(0.5, 0.5) + (-PropsArray[u_xlati0]._Colors.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * PropsArray[u_xlati0]._Colors.ww;
    vs_COLOR0 = PropsArray[u_xlati0]._Colors;
    u_xlat0.xy = u_xlat16_3.xy / u_xlat1.ww;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    u_xlat8.xy = u_xlat2.zz + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat8.xy;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _BackgroundTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
int u_xlati4;
vec2 u_xlat8;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = vec2(0.5, 0.5) + (-PropsArray[u_xlati0]._Colors.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * PropsArray[u_xlati0]._Colors.ww;
    vs_COLOR0 = PropsArray[u_xlati0]._Colors;
    u_xlat0.xy = u_xlat16_3.xy / u_xlat1.ww;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    u_xlat8.xy = u_xlat2.zz + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat8.xy;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _BackgroundTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
int u_xlati4;
vec2 u_xlat8;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat16_3.xy = vec2(0.5, 0.5) + (-PropsArray[u_xlati0]._Colors.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * PropsArray[u_xlati0]._Colors.ww;
    vs_COLOR0 = PropsArray[u_xlati0]._Colors;
    u_xlat0.xy = u_xlat16_3.xy / u_xlat1.ww;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    u_xlat8.xy = u_xlat2.zz + u_xlat2.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat8.xy;
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
uniform 	mediump vec4 _AdditiveTint;
UNITY_LOCATION(0) uniform mediump sampler2D _BackgroundTexture;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0 = texture(_BackgroundTexture, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_0.xyz + _AdditiveTint.xyz;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
}
}
}
}