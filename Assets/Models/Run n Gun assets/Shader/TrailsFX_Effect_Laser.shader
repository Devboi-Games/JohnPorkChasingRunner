//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "TrailsFX/Effect/Laser" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_LaserData ("Laser Data", Vector) = (0.1,20,0.1,1)
_Cull ("Cull", Float) = 2
}
SubShader {
 Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent+101" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 63787
Program "vp" {
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
out highp vec3 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _Colors;
uniform 	vec3 _LaserData;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _LaserData.x * 0.5 + abs(vs_TEXCOORD0.y);
    u_xlat1 = u_xlat0.x * _LaserData.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1 = u_xlat1>=(-u_xlat1);
#endif
    u_xlat1 = (u_xlatb1) ? _LaserData.x : (-_LaserData.x);
    u_xlat2.x = float(1.0) / u_xlat1;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = _LaserData.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat1 * u_xlat0.x + (-u_xlat2.x);
    u_xlat0.x = abs(u_xlat0.x) * _LaserData.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat1 = _Colors.w * _LaserData.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1 = u_xlat1>=(-u_xlat1);
#endif
    u_xlat1 = (u_xlatb1) ? _LaserData.z : (-_LaserData.z);
    u_xlat2.x = float(1.0) / u_xlat1;
    u_xlat2.x = u_xlat2.x * _Colors.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat1 = u_xlat2.x * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat2.y<u_xlat1);
#else
    u_xlatb1 = u_xlat2.y<u_xlat1;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat1 * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * _Colors;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _Colors;
uniform 	vec3 _LaserData;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _LaserData.x * 0.5 + abs(vs_TEXCOORD0.y);
    u_xlat1 = u_xlat0.x * _LaserData.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1 = u_xlat1>=(-u_xlat1);
#endif
    u_xlat1 = (u_xlatb1) ? _LaserData.x : (-_LaserData.x);
    u_xlat2.x = float(1.0) / u_xlat1;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = _LaserData.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat1 * u_xlat0.x + (-u_xlat2.x);
    u_xlat0.x = abs(u_xlat0.x) * _LaserData.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat1 = _Colors.w * _LaserData.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1 = u_xlat1>=(-u_xlat1);
#endif
    u_xlat1 = (u_xlatb1) ? _LaserData.z : (-_LaserData.z);
    u_xlat2.x = float(1.0) / u_xlat1;
    u_xlat2.x = u_xlat2.x * _Colors.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat1 = u_xlat2.x * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat2.y<u_xlat1);
#else
    u_xlatb1 = u_xlat2.y<u_xlat1;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat1 * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * _Colors;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _Colors;
uniform 	vec3 _LaserData;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec2 u_xlat2;
void main()
{
    u_xlat0.x = _LaserData.x * 0.5 + abs(vs_TEXCOORD0.y);
    u_xlat1 = u_xlat0.x * _LaserData.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1 = u_xlat1>=(-u_xlat1);
#endif
    u_xlat1 = (u_xlatb1) ? _LaserData.x : (-_LaserData.x);
    u_xlat2.x = float(1.0) / u_xlat1;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = _LaserData.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat1 * u_xlat0.x + (-u_xlat2.x);
    u_xlat0.x = abs(u_xlat0.x) * _LaserData.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat1 = _Colors.w * _LaserData.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1 = u_xlat1>=(-u_xlat1);
#endif
    u_xlat1 = (u_xlatb1) ? _LaserData.z : (-_LaserData.z);
    u_xlat2.x = float(1.0) / u_xlat1;
    u_xlat2.x = u_xlat2.x * _Colors.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat1 = u_xlat2.x * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat2.y<u_xlat1);
#else
    u_xlatb1 = u_xlat2.y<u_xlat1;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat1 * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * _Colors;
    SV_Target0 = u_xlat0;
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
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
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
uniform 	int unity_BaseInstanceID;
uniform 	vec3 _LaserData;
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
flat in highp uint vs_SV_InstanceID0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec2 u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _LaserData.x * 0.5 + abs(vs_TEXCOORD0.y);
    u_xlat2 = u_xlat0.x * _LaserData.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _LaserData.x : (-_LaserData.x);
    u_xlat4.x = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4.xy = _LaserData.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4.x);
    u_xlat0.x = abs(u_xlat0.x) * _LaserData.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlati2 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = _LaserData.z * PropsArray[u_xlati2]._Colors.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb4 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = (u_xlatb4) ? _LaserData.z : (-_LaserData.z);
    u_xlat1 = float(1.0) / u_xlat4.x;
    u_xlat1 = u_xlat1 * PropsArray[u_xlati2]._Colors.w;
    u_xlat1 = fract(u_xlat1);
    u_xlat4.x = u_xlat4.x * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y<u_xlat4.x);
#else
    u_xlatb4 = u_xlat4.y<u_xlat4.x;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * PropsArray[u_xlati2]._Colors;
    SV_Target0 = u_xlat0;
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
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
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
uniform 	int unity_BaseInstanceID;
uniform 	vec3 _LaserData;
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
flat in highp uint vs_SV_InstanceID0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec2 u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _LaserData.x * 0.5 + abs(vs_TEXCOORD0.y);
    u_xlat2 = u_xlat0.x * _LaserData.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _LaserData.x : (-_LaserData.x);
    u_xlat4.x = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4.xy = _LaserData.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4.x);
    u_xlat0.x = abs(u_xlat0.x) * _LaserData.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlati2 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = _LaserData.z * PropsArray[u_xlati2]._Colors.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb4 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = (u_xlatb4) ? _LaserData.z : (-_LaserData.z);
    u_xlat1 = float(1.0) / u_xlat4.x;
    u_xlat1 = u_xlat1 * PropsArray[u_xlati2]._Colors.w;
    u_xlat1 = fract(u_xlat1);
    u_xlat4.x = u_xlat4.x * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y<u_xlat4.x);
#else
    u_xlatb4 = u_xlat4.y<u_xlat4.x;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * PropsArray[u_xlati2]._Colors;
    SV_Target0 = u_xlat0;
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
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
flat out highp uint vs_SV_InstanceID0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = in_POSITION0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
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
uniform 	int unity_BaseInstanceID;
uniform 	vec3 _LaserData;
struct PropsArray_Type {
	mediump vec4 _Colors;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
flat in highp uint vs_SV_InstanceID0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
float u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec2 u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _LaserData.x * 0.5 + abs(vs_TEXCOORD0.y);
    u_xlat2 = u_xlat0.x * _LaserData.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _LaserData.x : (-_LaserData.x);
    u_xlat4.x = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4.xy = _LaserData.xz * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4.x);
    u_xlat0.x = abs(u_xlat0.x) * _LaserData.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlati2 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = _LaserData.z * PropsArray[u_xlati2]._Colors.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb4 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = (u_xlatb4) ? _LaserData.z : (-_LaserData.z);
    u_xlat1 = float(1.0) / u_xlat4.x;
    u_xlat1 = u_xlat1 * PropsArray[u_xlati2]._Colors.w;
    u_xlat1 = fract(u_xlat1);
    u_xlat4.x = u_xlat4.x * u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y<u_xlat4.x);
#else
    u_xlatb4 = u_xlat4.y<u_xlat4.x;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * PropsArray[u_xlati2]._Colors;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
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