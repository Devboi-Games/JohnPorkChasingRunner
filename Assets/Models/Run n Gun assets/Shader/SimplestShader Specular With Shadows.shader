//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "SimplestShader Specular With Shadows" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Brightness ("_Brightness", Float) = 0
_ShadowStrength ("Shadow Strength", Range(0, 1)) = 0.4
_Curvature ("_LightDir", Vector) = (0.5,0.5,1,1)
_LightColor ("_LightColor", Color) = (1,1,1,1)
_ShadowColor ("_ShadowColor", Color) = (1,1,1,1)
_SpecularColor ("_SpecularColor", Color) = (1,1,1,1)
_Glossiness ("_Glossiness", Float) = 0.5
_Falloff ("_Falloff", Range(0, 1)) = 0
_FalloffPower ("_Falloff Power", Float) = 1
_FalloffColor ("Falloff Color", Color) = (1,1,1,1)
_Alpha ("Alpha", Range(0, 1)) = 1
_SlowMotionDependence ("SlowMotionDependence", Range(0, 1)) = 1
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" }
  GpuProgramID 15405
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat10_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat10_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    u_xlat9 = u_xlat1.y + u_xlat1.x;
    u_xlat9 = u_xlat16_0.z * vs_COLOR0.z + u_xlat9;
    u_xlat10 = u_xlat9 * 0.333299994;
    u_xlat2.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat2.xyz + vec3(u_xlat10);
    u_xlat0.xyz = (-u_xlat16_0.xyz) * vs_COLOR0.xyz + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(2) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
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
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_7;
float u_xlat15;
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
    u_xlat16_2 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_7.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = u_xlat15 * _Curvature.x + _Curvature.y;
    u_xlat1.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _ShadowColor.xyz;
    u_xlat15 = u_xlat0.y * _Curvature.z;
    u_xlat15 = u_xlat15 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat4.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_2) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * _Falloff;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _FalloffPower;
    u_xlat15 = exp2(u_xlat15);
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Glossiness;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat1.w = 1.0;
    u_xlat1 = u_xlat0.xxxx * _SpecularColor + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat15) * u_xlat2 + u_xlat1;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat6 = u_xlat0.y + u_xlat0.x;
    u_xlat6 = u_xlat0.z + u_xlat6;
    u_xlat1.x = u_xlat6 * 0.333299994;
    u_xlat3.xyz = (-vec3(u_xlat6)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat1.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat3.xyz + u_xlat1.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat6 = _SlowMotion * _SlowMotionWeight;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat6);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _LightColor0;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _Curvature;
uniform 	float _Glossiness;
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
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_9;
float u_xlat19;
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
    u_xlat16_3 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = inversesqrt(u_xlat16_3);
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _WorldSpaceLightPos0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat16_9.xyz);
    u_xlat19 = max(u_xlat19, 0.0);
    u_xlat19 = u_xlat19 * _Curvature.x + _Curvature.y;
    u_xlat2.xyz = _LightColor.xyz * _LightColor0.xyz + (-_ShadowColor.xyz);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz + _ShadowColor.xyz;
    u_xlat19 = u_xlat1.y * _Curvature.z;
    u_xlat19 = u_xlat19 * 0.5 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat16_3) + u_xlat4.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 * _Falloff;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _FalloffPower;
    u_xlat19 = exp2(u_xlat19);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Glossiness;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat2.w = 1.0;
    u_xlat2 = u_xlat1.xxxx * _SpecularColor + u_xlat2;
    u_xlat3 = (-u_xlat2) + _FalloffColor;
    vs_COLOR0 = vec4(u_xlat19) * u_xlat3 + u_xlat2;
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
uniform 	float _SlowMotionDependence;
uniform 	float _SlowMotion;
uniform 	vec4 _SlowMotionColor;
uniform 	float _SlowMotionWeight;
uniform 	float _SlowMotionRecolor;
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
vec3 u_xlat5;
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
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat9 = u_xlat0.y + u_xlat0.x;
    u_xlat9 = u_xlat0.z + u_xlat9;
    u_xlat2.x = u_xlat9 * 0.333299994;
    u_xlat5.xyz = (-vec3(u_xlat9)) * vec3(0.333299994, 0.333299994, 0.333299994) + _SlowMotionColor.xyz;
    u_xlat2.xyz = vec3(vec3(_SlowMotionRecolor, _SlowMotionRecolor, _SlowMotionRecolor)) * u_xlat5.xyz + u_xlat2.xxx;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = _SlowMotion * _SlowMotionWeight;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat9);
    SV_Target0.xyz = vec3(vec3(_SlowMotionDependence, _SlowMotionDependence, _SlowMotionDependence)) * u_xlat2.xyz + u_xlat0.xyz;
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