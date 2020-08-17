// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CScape/CSStreetShader"
{
	Properties
	{
		_Normal1("Normal 1", 2D) = "bump" {}
		_Specular("Specular", 2D) = "white" {}
		[Gamma]_Smoothness("Smoothness", 2D) = "white" {}
		_Puddles("Puddles", Float) = 0
		_TextureSample6("Texture Sample 6", 2D) = "white" {}
		_Float3("Float 3", Float) = 1
		_Float2("Float 2", Float) = 0
		_Float6("Float 6", Float) = 0
		_grate("grate", 2D) = "white" {}
		_Noise("Noise", 2D) = "white" {}
		_GrateFrequency("GrateFrequency", Float) = 0
		_faloff("faloff", Float) = 0
		_grate1("grate 1", 2D) = "bump" {}
		_GrateSpecular("GrateSpecular", Float) = 0
		_NormalStrenght("NormalStrenght", Float) = 0
		_Mettalic("Mettalic", Float) = 0
		_Float7("Float 7", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_StreetDecalls("StreetDecalls", 2DArray ) = "" {}
		_Float9("Float 9", Float) = 0
		_AlbedoCol("AlbedoCol", Color) = (0,0,0,0)
		_StreetsArray("StreetsArray", 2DArray ) = "" {}
		_TireShineless("TireShineless", Float) = 0
		_ScaleNoise2("ScaleNoise2", Float) = 0
		_ScaleNoise1("ScaleNoise1", Float) = 0
		_lightsContour("lightsContour", Float) = 0.1
		_LightsDistance("LightsDistance", Float) = 0.1
		_ReLightTreshold("ReLightTreshold", Range( 0 , 1)) = 0.32
		_ErodeSigns("ErodeSigns", Range( 0 , 1)) = 0
		_Sidewalk_Albedo("Sidewalk_Albedo", Color) = (0,0,0,0)
		_Patches("Patches", Float) = 0
		_patchesLightness("patchesLightness", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv4_texcoord4;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _NormalStrenght;
		uniform float _Patches;
		uniform sampler2D _Smoothness;
		uniform float _ScaleNoise1;
		uniform sampler2D _TextureSample6;
		uniform float _ScaleNoise2;
		uniform float _patchesLightness;
		uniform sampler2D _Normal1;
		uniform float _Puddles;
		uniform float _Float2;
		uniform sampler2D _grate1;
		uniform float _faloff;
		uniform sampler2D _Noise;
		uniform float _GrateFrequency;
		uniform sampler2D _grate;
		uniform UNITY_DECLARE_TEX2DARRAY( _StreetsArray );
		uniform UNITY_DECLARE_TEX2DARRAY( _StreetDecalls );
		uniform float4 _StreetDecalls_ST;
		uniform float _ErodeSigns;
		uniform sampler2D _TextureSample0;
		uniform float4 _AlbedoCol;
		uniform float4 _Sidewalk_Albedo;
		uniform float _CSReLight;
		uniform float _ReLightTreshold;
		uniform float4 _reLightColor;
		uniform float _LightsDistance;
		uniform float _lightsContour;
		uniform float _CSReLightDistance;
		uniform float _Float3;
		uniform float _Float7;
		uniform sampler2D _Specular;
		uniform float _Float6;
		uniform float _GrateSpecular;
		uniform float _Mettalic;
		uniform float _Float9;
		uniform float _TireShineless;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult427 = (float2(ase_worldPos.y , ase_worldPos.z));
			float2 appendResult423 = (float2(ase_worldPos.y , ase_worldPos.x));
			float2 appendResult376 = (float2(ase_worldPos.x , ase_worldPos.z));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float temp_output_415_0 = abs( ase_vertexNormal.z );
			float2 lerpResult422 = lerp( appendResult423 , appendResult376 , step( temp_output_415_0 , 0.5 ));
			float2 lerpResult426 = lerp( appendResult427 , lerpResult422 , step( abs( ase_vertexNormal.x ) , 0.5 ));
			float2 worldUV414 = lerpResult426;
			float4 tex2DNode325 = tex2D( _Smoothness, ( worldUV414 * _ScaleNoise1 ) );
			float4 tex2DNode337 = tex2D( _TextureSample6, ( worldUV414 * _ScaleNoise2 ) );
			float blendOpSrc522 = tex2DNode325.g;
			float blendOpDest522 = tex2DNode337.g;
			float smoothstepResult532 = smoothstep( _Patches , ( _Patches + 0.2 ) , ( saturate( ( blendOpDest522 / blendOpSrc522 ) )));
			float clampResult538 = clamp( ( smoothstepResult532 + _patchesLightness ) , 0.0 , 1.0 );
			float smoothstepResult327 = smoothstep( _Puddles , ( _Puddles + 0.7 ) , ( ( tex2DNode337.r * _Float2 ) + tex2DNode325.r ));
			float3 lerpResult331 = lerp( float3(0,0,1) , UnpackScaleNormal( tex2D( _Normal1, worldUV414 ) ,( _NormalStrenght * clampResult538 ) ) , smoothstepResult327);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float2 appendResult370 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 temp_output_373_0 = ( appendResult370 * float2( 1,1 ) );
			float smoothstepResult358 = smoothstep( _faloff , ( _faloff + 0.01 ) , ( tex2D( _Noise, ( temp_output_373_0 / float2( 64,64 ) ) ).r * _GrateFrequency ));
			float4 tex2DNode353 = tex2D( _grate, temp_output_373_0 );
			float temp_output_367_0 = ( smoothstepResult358 * tex2DNode353.a );
			float3 lerpResult362 = lerp( lerpResult331 , UnpackNormal( tex2D( _grate1, temp_output_373_0 ) ) , temp_output_367_0);
			o.Normal = lerpResult362;
			float4 texArray400 = UNITY_SAMPLE_TEX2DARRAY(_StreetsArray, float3(worldUV414, i.uv4_texcoord4.x)  );
			float lerpResult517 = lerp( 0.5 , 1.0 , smoothstepResult327);
			float2 uv_StreetDecalls = i.uv_texcoord * _StreetDecalls_ST.xy + _StreetDecalls_ST.zw;
			float4 texArray384 = UNITY_SAMPLE_TEX2DARRAY(_StreetDecalls, float3(uv_StreetDecalls, ( i.vertexColor.r * 10.0 ))  );
			float2 uv_TexCoord485 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float clampResult507 = clamp( ( step( frac( ( ( ( 1.0 - uv_TexCoord485 ) + float2( 0,0 ) ) * float2( 0.5,0.5 ) ) ) , float2( 0.03,0.03 ) ).x + step( frac( ( ( ( 1.0 - uv_TexCoord485 ) + float2( 0,0 ) ) * float2( 0.5,0.5 ) ) ) , float2( 0.03,0.03 ) ).y ) , 0.0 , 1.0 );
			float temp_output_490_0 = ( 0.5 + 0.04 );
			float smoothstepResult488 = smoothstep( 0.5 , temp_output_490_0 , frac( ( uv_TexCoord485.y * 2.0 ) ));
			float smoothstepResult494 = smoothstep( 0.5 , temp_output_490_0 , frac( ( uv_TexCoord485.x * 2.0 ) ));
			float SplitLineMask511 = ( clampResult507 * abs( ( smoothstepResult488 - smoothstepResult494 ) ) );
			float lerpResult513 = lerp( texArray384.x , 0.0 , SplitLineMask511);
			float4 temp_cast_0 = (lerpResult513).xxxx;
			float DiffuseCol475 = texArray400.r;
			float smoothstepResult481 = smoothstep( _ErodeSigns , ( _ErodeSigns + 0.1 ) , DiffuseCol475);
			float clampResult478 = clamp( ( lerpResult513 * smoothstepResult481 ) , 0.0 , 1.0 );
			float4 lerpResult352 = lerp( ( texArray400 * lerpResult517 ) , temp_cast_0 , clampResult478);
			float4 lerpResult357 = lerp( lerpResult352 , tex2DNode353 , temp_output_367_0);
			float4 lerpResult382 = lerp( lerpResult357 , tex2D( _TextureSample0, worldUV414 ) , i.vertexColor.g);
			float OldMask523 = clampResult538;
			float clampResult521 = clamp( i.uv4_texcoord4.x , 0.0 , 1.0 );
			float4 lerpResult519 = lerp( _AlbedoCol , ( _Sidewalk_Albedo * OldMask523 ) , step( clampResult521 , 0.9 ));
			float4 temp_output_398_0 = ( lerpResult382 * lerpResult519 );
			o.Albedo = temp_output_398_0.rgb;
			float2 appendResult450 = (float2(frac( ( ase_worldPos.x * _LightsDistance ) ) , frac( ( ase_worldPos.z * _LightsDistance ) )));
			float clampResult470 = clamp( ( distance( ase_worldPos , _WorldSpaceCameraPos ) * _CSReLightDistance ) , 0.0 , 1.0 );
			float4 ifLocalVar464 = 0;
			UNITY_BRANCH 
			if( _CSReLight < _ReLightTreshold )
				ifLocalVar464 = ( ( temp_output_398_0 * _reLightColor * ase_worldNormal.y * ( 1.0 - distance( ( appendResult450 * _lightsContour ) , ( float2( 0.5,0.5 ) * _lightsContour ) ) ) * ( _reLightColor.a * 10.0 ) ) * clampResult470 );
			o.Emission = ifLocalVar464.rgb;
			float clampResult381 = clamp( smoothstepResult327 , 0.1 , 1.0 );
			float lerpResult326 = lerp( _Float3 , smoothstepResult327 , clampResult381);
			float4 temp_cast_3 = (( lerpResult326 + _Float7 )).xxxx;
			float4 lerpResult335 = lerp( temp_cast_3 , ( tex2D( _Specular, worldUV414 ) * _Float6 ) , clampResult381);
			float4 temp_cast_4 = (( tex2DNode353.r * _GrateSpecular )).xxxx;
			float4 lerpResult363 = lerp( lerpResult335 , temp_cast_4 , temp_output_367_0);
			float4 clampResult395 = clamp( lerpResult363 , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			o.Specular = ( clampResult395 * _Mettalic ).rgb;
			o.Smoothness = ( ( lerpResult363 * _Float9 ) + ( texArray384.y * _TireShineless * temp_output_398_0 ) ).r;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers d3d9 gles d3d11_9x ps4 psp2 n3ds 
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv4_texcoord4;
				o.customPack1.xy = v.texcoord3;
				o.customPack1.zw = customInputData.uv_texcoord;
				o.customPack1.zw = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv4_texcoord4 = IN.customPack1.xy;
				surfIN.uv_texcoord = IN.customPack1.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13901
271;376;1489;529;-6490.652;-1757.608;1.569399;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;485;6484.817,1245.312;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;417;1437.886,1806.935;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;514;6774.799,1396.059;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.AbsOpNode;415;1735.746,1777.943;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;375;1419.291,1495.922;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;505;6758.216,1467.837;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;423;1779.877,1586.398;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.StepOpNode;421;1950.157,1899.866;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.AbsOpNode;424;1715.017,1894.96;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;501;6721.132,1658.117;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;376;1678.686,1486.139;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.StepOpNode;425;1929.428,2016.883;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;427;1912.469,1715.265;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.LerpOp;422;1997.956,1520.266;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0,0,0;False;2;FLOAT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;489;7171.063,1563.006;Float;False;Constant;_tiling;tiling;43;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.FractNode;503;6873.357,1668.688;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;486;7172.736,1386.634;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;492;7182.447,1275.692;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;426;2188.847,1653.221;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0,0,0;False;2;FLOAT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;490;7348.418,1640.836;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.04;False;1;FLOAT
Node;AmplifyShaderEditor.FractNode;487;7386.444,1528.709;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.FractNode;493;7458.44,1210.388;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.StepOpNode;504;7034.039,1681.374;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.03,0.03;False;1;FLOAT2
Node;AmplifyShaderEditor.RegisterLocalVarNode;414;2256.868,1471.077;Float;False;worldUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;411;2749.718,1465.756;Float;False;Property;_ScaleNoise2;ScaleNoise2;28;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;508;7212.088,1746.914;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;494;7710.382,1326.508;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;488;7680.112,1535.975;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;410;2908.001,1338.53;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;412;2534.803,1202.865;Float;False;Property;_ScaleNoise1;ScaleNoise1;29;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;497;7894.598,1543.986;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;369;2713.759,3700.51;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;506;7500.078,1753.257;Float;False;2;2;0;FLOAT;0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.AbsOpNode;499;7942.897,1661.324;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;409;2816.709,1086.019;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;337;3207.932,1190.001;Float;True;Property;_TextureSample6;Texture Sample 6;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;507;7658.645,1763.585;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.TexCoordVertexDataNode;403;2009.105,1072.194;Float;False;3;2;0;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;370;3030.558,3654.014;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;342;3628.602,1073.813;Float;False;Property;_Float2;Float 2;7;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;347;3675.506,2566.312;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;3845.802,1021.012;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;325;3222.06,895.1548;Float;True;Property;_Smoothness;Smoothness;3;1;[Gamma];None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;3214.359,3801.212;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2
Node;AmplifyShaderEditor.TextureArrayNode;400;2344.598,992.7512;Float;True;Property;_StreetsArray;StreetsArray;25;0;None;0;Object;-1;Auto;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;509;7876.268,1800.098;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;396;3847.854,2931.812;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;10.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;482;3993.128,2991.28;Float;False;Property;_ErodeSigns;ErodeSigns;35;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;328;3464.001,1527.112;Float;False;Property;_Puddles;Puddles;4;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;533;4007.01,1007.99;Float;False;Property;_Patches;Patches;37;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;372;3298.258,3513.614;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;64,64;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;483;4198.566,3111.499;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.1;False;1;FLOAT
Node;AmplifyShaderEditor.TextureArrayNode;384;3904.08,2735.84;Float;True;Property;_StreetDecalls;StreetDecalls;20;0;None;0;Object;-1;Auto;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BlendOpsNode;522;3839,844.3472;Float;False;Divide;True;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;534;4196.192,1050.982;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.2;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;512;4195.51,2590.588;Float;False;511;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;329;3723.805,1580.812;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.7;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;340;3690.803,1279.713;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;511;8152.563,1824.632;Float;False;SplitLineMask;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;475;2739.727,925.8188;Float;False;DiffuseCol;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;476;4030.957,2961.706;Float;False;475;0;1;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;447;5383.348,2961.312;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;327;3932.499,1408.711;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;462;5416.572,3240.254;Float;False;Property;_LightsDistance;LightsDistance;33;0;0.1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;481;4324.682,3022.621;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;356;3408.656,3308.21;Float;False;Property;_GrateFrequency;GrateFrequency;11;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;360;3479.756,3490.91;Float;False;Property;_faloff;faloff;12;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;513;4394.967,2707.151;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;532;4442.536,916.3994;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;354;3351.658,3011.811;Float;True;Property;_Noise;Noise;10;0;Assets/CScape/Textures/Noise.psd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;536;4637.575,1102.486;Float;False;Property;_patchesLightness;patchesLightness;38;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;355;3670.857,3051.71;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;461;5651.866,3139.184;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;477;4511.087,2870.742;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;517;4274.795,1622.937;Float;False;3;0;FLOAT;0.5;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;460;5669.444,3009.551;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;537;4824.104,944.4852;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;359;3760.65,3216.975;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.01;False;1;FLOAT
Node;AmplifyShaderEditor.FractNode;449;5844.901,2823.859;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;358;3886.121,3074.563;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;353;3478.058,3685.009;Float;True;Property;_grate;grate;9;0;Assets/CScape/Textures/grate.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;478;4673.135,2835.784;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.FractNode;448;5854.411,2717.779;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;538;4975.521,887.4293;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;336;4208.763,2322.016;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ClampOpNode;381;3996.953,1778.71;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.1;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;330;3553.202,1736.711;Float;False;Property;_Float3;Float 3;6;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;326;3909.6,1993.014;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;350;3644.947,2343.99;Float;False;Property;_Float6;Float 6;8;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;525;4729.797,1693.537;Float;False;523;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;518;4730.845,1520.337;Float;False;Property;_Sidewalk_Albedo;Sidewalk_Albedo;36;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;456;6021.876,2933.626;Float;False;Property;_lightsContour;lightsContour;32;0;0.1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.Vector2Node;458;6287.499,2900.321;Float;False;Constant;_Vector2;Vector 2;42;0;0.5,0.5;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;521;5035,1786.646;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;352;4776.195,2647.963;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;523;5202.465,838.2023;Float;False;OldMask;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;367;4313.387,3162.19;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;450;6020.785,2697.479;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;380;4026.859,2126.812;Float;False;Property;_Float7;Float 7;17;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;321;3173.82,2255.97;Float;True;Property;_Specular;Specular;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;455;6224.597,2688.146;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.StepOpNode;520;5211.859,1805.473;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.9;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;357;4982.109,2826.04;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;366;4474.028,2575.442;Float;False;Property;_GrateSpecular;GrateSpecular;14;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;459;6512.328,2848.971;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;349;3833.441,2175.983;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WorldSpaceCameraPos;473;6103.038,2484.39;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;524;5398.189,1628.553;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;379;4215.56,2031.412;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;383;4496.195,1855.496;Float;True;Property;_TextureSample0;Texture Sample 0;19;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;397;5057.265,1494.872;Float;False;Property;_AlbedoCol;AlbedoCol;24;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;335;4439.099,2217.215;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.DistanceOpNode;472;6372.493,2365.226;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;365;4743.316,2476.463;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;519;5457.874,1829.31;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;474;6450.713,2515.111;Float;False;Global;_CSReLightDistance;_CSReLightDistance;45;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DistanceOpNode;451;6703.454,2730.335;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;374;2494.358,1681.812;Float;False;Property;_NormalStrenght;NormalStrenght;15;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;444;5612.499,2258.631;Float;False;Global;_reLightColor;_reLightColor;41;0;0.8676471,0.7320442,0.4402033,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;382;4995.229,1957.146;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.OneMinusNode;454;6442.242,2617.465;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;394;5220.456,2646.79;Float;False;Property;_Float9;Float 9;23;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;407;5183.982,2829.319;Float;False;Property;_TireShineless;TireShineless;27;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;445;5685.553,2087.572;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;471;6591.831,2373.939;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.01;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;363;4997.356,2467.609;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;539;2832.578,1936.378;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;398;5518.367,1965.153;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;463;5740.201,2479.74;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;10.0;False;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;470;6782.502,2316.713;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;393;5354.853,2382.08;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.Vector3Node;333;3424.403,1855.112;Float;False;Constant;_Vector0;Vector 0;17;0;0,0,1;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;443;5965.004,2154.95;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;3;FLOAT;0,0,0,0;False;4;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;406;5408.436,2689.744;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.ClampOpNode;395;5056.756,2304.212;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;378;4863.66,2212.411;Float;False;Property;_Mettalic;Mettalic;16;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;318;2909.003,1653.811;Float;True;Property;_Normal1;Normal 1;0;0;None;True;0;True;bump;LockedToTexture2D;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;466;6322.142,2016.222;Float;False;Global;_CSReLight;_CSReLight;44;0;2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;405;5557.326,2542.627;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;331;3551.24,2144.968;Float;False;3;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0.0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;469;6310.372,2232.729;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;467;5968.244,2064.123;Float;False;Property;_ReLightTreshold;ReLightTreshold;34;0;0.32;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;361;4283.355,3543.71;Float;True;Property;_grate1;grate 1;13;0;Assets/CScape/Textures/grate 1.png;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;377;5195.261,2203.711;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ConditionalIfNode;464;6596.646,2024.523;Float;False;True;5;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0.0;False;4;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.TexCoordVertexDataNode;531;2673.553,742.8105;Float;False;0;2;0;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;529;2691.684,711.8671;Float;False;Constant;_Float0;Float 0;37;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;283;2885.483,3396.796;Float;False;Property;_Lightsheight;Lightsheight;21;0;0.05;0;0.05;0;1;FLOAT
Node;AmplifyShaderEditor.WorldToObjectTransfNode;280;2980.783,2782.091;Float;False;1;0;FLOAT4;0,0,0,0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PowerNode;288;3679.881,2473.301;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;437;5665.297,1588.038;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;390;4022.454,2615.409;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT
Node;AmplifyShaderEditor.RelayNode;491;7528.666,1896.938;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.AbsOpNode;416;1561.034,2085.881;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;281;3228.981,2584.498;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;404;2177.966,825.8027;Float;False;Property;_Float10;Float 10;26;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;392;3697.854,2964.608;Float;False;Property;_Float8;Float 8;18;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;282;3168.484,2738.495;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RelayNode;515;7805.895,2102.366;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RelayNode;516;7826.219,2219.619;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.PosVertexDataNode;413;1936.499,1265.714;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;452;5781.417,3329.09;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;418;2229.779,1895.48;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;528;3059.916,1135.137;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;527;3032.175,789.0443;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;435;5505.616,1505.572;Float;False;Property;_Raindrops;Raindrops;31;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;431;5968.491,1603.182;Float;False;Constant;_Float11;Float 11;40;0;0.3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ConditionalIfNode;438;5850.747,1458.142;Float;False;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;420;5401.044,2094.303;Float;False;-1;0;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;364;4294.758,3338.708;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ConditionalIfNode;433;6377.646,1494.172;Float;False;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;385;3526.151,2882.209;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;362;4930.456,3029.31;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;429;6196.125,1620.581;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;386;3646.549,2842.509;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;314;2504.5,1861.113;Float;False;Constant;_Color2;Color 2;7;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;285;3456.682,2575.496;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;289;3459.078,2480.395;Float;False;Property;_Float4;Float 4;22;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCIf;440;6117.942,1489.342;Float;False;6;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT;0.0;False;5;FLOAT;0.05;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;436;5338.943,1438.611;Float;False;Constant;_Float13;Float 13;41;0;0.01;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;432;5484,1229.889;Float;True;Property;_rainDrops;rainDrops;30;0;Assets/CScape/Textures/rainDrops.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;439;6121.846,1688.243;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;320;4223.002,1421.512;Float;False;Property;_Float1;Float 1;1;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;293;3074.418,2483.097;Float;False;Constant;_Float5;Float 5;38;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;279;3031.885,3067.493;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;441;6411.349,1660.497;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SmoothstepOpNode;434;5824.285,1605.934;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;430;6107.17,1622.973;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;8099.23,1969.781;Float;False;True;3;Float;ASEMaterialInspector;0;0;StandardSpecular;CScape/CSStreetShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;False;True;True;False;True;True;False;True;True;False;False;False;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;514;0;485;0
WireConnection;415;0;417;3
WireConnection;505;0;514;0
WireConnection;423;0;375;2
WireConnection;423;1;375;1
WireConnection;421;0;415;0
WireConnection;424;0;417;1
WireConnection;501;0;505;0
WireConnection;376;0;375;1
WireConnection;376;1;375;3
WireConnection;425;0;424;0
WireConnection;427;0;375;2
WireConnection;427;1;375;3
WireConnection;422;0;423;0
WireConnection;422;1;376;0
WireConnection;422;2;421;0
WireConnection;503;0;501;0
WireConnection;486;0;485;2
WireConnection;492;0;485;1
WireConnection;426;0;427;0
WireConnection;426;1;422;0
WireConnection;426;2;425;0
WireConnection;490;0;489;0
WireConnection;487;0;486;0
WireConnection;493;0;492;0
WireConnection;504;0;503;0
WireConnection;414;0;426;0
WireConnection;508;0;504;0
WireConnection;494;0;493;0
WireConnection;494;1;489;0
WireConnection;494;2;490;0
WireConnection;488;0;487;0
WireConnection;488;1;489;0
WireConnection;488;2;490;0
WireConnection;410;0;414;0
WireConnection;410;1;411;0
WireConnection;497;0;488;0
WireConnection;497;1;494;0
WireConnection;506;0;508;0
WireConnection;506;1;508;1
WireConnection;499;0;497;0
WireConnection;409;0;414;0
WireConnection;409;1;412;0
WireConnection;337;1;410;0
WireConnection;507;0;506;0
WireConnection;370;0;369;1
WireConnection;370;1;369;3
WireConnection;341;0;337;1
WireConnection;341;1;342;0
WireConnection;325;1;409;0
WireConnection;373;0;370;0
WireConnection;400;0;414;0
WireConnection;400;1;403;1
WireConnection;509;0;507;0
WireConnection;509;1;499;0
WireConnection;396;0;347;1
WireConnection;372;0;373;0
WireConnection;483;0;482;0
WireConnection;384;1;396;0
WireConnection;522;0;325;2
WireConnection;522;1;337;2
WireConnection;534;0;533;0
WireConnection;329;0;328;0
WireConnection;340;0;341;0
WireConnection;340;1;325;1
WireConnection;511;0;509;0
WireConnection;475;0;400;1
WireConnection;327;0;340;0
WireConnection;327;1;328;0
WireConnection;327;2;329;0
WireConnection;481;0;476;0
WireConnection;481;1;482;0
WireConnection;481;2;483;0
WireConnection;513;0;384;1
WireConnection;513;2;512;0
WireConnection;532;0;522;0
WireConnection;532;1;533;0
WireConnection;532;2;534;0
WireConnection;354;1;372;0
WireConnection;355;0;354;1
WireConnection;355;1;356;0
WireConnection;461;0;447;3
WireConnection;461;1;462;0
WireConnection;477;0;513;0
WireConnection;477;1;481;0
WireConnection;517;2;327;0
WireConnection;460;0;447;1
WireConnection;460;1;462;0
WireConnection;537;0;532;0
WireConnection;537;1;536;0
WireConnection;359;0;360;0
WireConnection;449;0;461;0
WireConnection;358;0;355;0
WireConnection;358;1;360;0
WireConnection;358;2;359;0
WireConnection;353;1;373;0
WireConnection;478;0;477;0
WireConnection;448;0;460;0
WireConnection;538;0;537;0
WireConnection;336;0;400;0
WireConnection;336;1;517;0
WireConnection;381;0;327;0
WireConnection;326;0;330;0
WireConnection;326;1;327;0
WireConnection;326;2;381;0
WireConnection;521;0;403;1
WireConnection;352;0;336;0
WireConnection;352;1;513;0
WireConnection;352;2;478;0
WireConnection;523;0;538;0
WireConnection;367;0;358;0
WireConnection;367;1;353;4
WireConnection;450;0;448;0
WireConnection;450;1;449;0
WireConnection;321;1;414;0
WireConnection;455;0;450;0
WireConnection;455;1;456;0
WireConnection;520;0;521;0
WireConnection;357;0;352;0
WireConnection;357;1;353;0
WireConnection;357;2;367;0
WireConnection;459;0;458;0
WireConnection;459;1;456;0
WireConnection;349;0;321;0
WireConnection;349;1;350;0
WireConnection;524;0;518;0
WireConnection;524;1;525;0
WireConnection;379;0;326;0
WireConnection;379;1;380;0
WireConnection;383;1;414;0
WireConnection;335;0;379;0
WireConnection;335;1;349;0
WireConnection;335;2;381;0
WireConnection;472;0;447;0
WireConnection;472;1;473;0
WireConnection;365;0;353;1
WireConnection;365;1;366;0
WireConnection;519;0;397;0
WireConnection;519;1;524;0
WireConnection;519;2;520;0
WireConnection;451;0;455;0
WireConnection;451;1;459;0
WireConnection;382;0;357;0
WireConnection;382;1;383;0
WireConnection;382;2;347;2
WireConnection;454;0;451;0
WireConnection;471;0;472;0
WireConnection;471;1;474;0
WireConnection;363;0;335;0
WireConnection;363;1;365;0
WireConnection;363;2;367;0
WireConnection;539;0;374;0
WireConnection;539;1;538;0
WireConnection;398;0;382;0
WireConnection;398;1;519;0
WireConnection;463;0;444;4
WireConnection;470;0;471;0
WireConnection;393;0;363;0
WireConnection;393;1;394;0
WireConnection;443;0;398;0
WireConnection;443;1;444;0
WireConnection;443;2;445;2
WireConnection;443;3;454;0
WireConnection;443;4;463;0
WireConnection;406;0;384;2
WireConnection;406;1;407;0
WireConnection;406;2;398;0
WireConnection;395;0;363;0
WireConnection;318;1;414;0
WireConnection;318;5;539;0
WireConnection;405;0;393;0
WireConnection;405;1;406;0
WireConnection;331;0;333;0
WireConnection;331;1;318;0
WireConnection;331;2;327;0
WireConnection;469;0;443;0
WireConnection;469;1;470;0
WireConnection;361;1;373;0
WireConnection;377;0;395;0
WireConnection;377;1;378;0
WireConnection;464;0;466;0
WireConnection;464;1;467;0
WireConnection;464;4;469;0
WireConnection;280;0;279;0
WireConnection;288;0;285;0
WireConnection;288;1;289;0
WireConnection;437;0;435;0
WireConnection;437;1;436;0
WireConnection;390;0;347;1
WireConnection;491;0;398;0
WireConnection;281;0;282;0
WireConnection;282;0;280;2
WireConnection;282;1;283;0
WireConnection;515;0;377;0
WireConnection;516;0;405;0
WireConnection;418;0;415;0
WireConnection;527;0;531;0
WireConnection;527;1;529;0
WireConnection;438;0;432;1
WireConnection;438;1;435;0
WireConnection;364;0;353;1
WireConnection;385;0;347;4
WireConnection;385;1;347;1
WireConnection;362;0;331;0
WireConnection;362;1;361;0
WireConnection;362;2;367;0
WireConnection;429;0;398;0
WireConnection;429;1;430;0
WireConnection;429;2;441;0
WireConnection;386;0;385;0
WireConnection;285;0;281;0
WireConnection;440;0;432;1
WireConnection;440;1;435;0
WireConnection;439;0;434;0
WireConnection;439;1;440;0
WireConnection;441;0;434;0
WireConnection;441;1;440;0
WireConnection;434;0;432;1
WireConnection;434;1;435;0
WireConnection;434;2;437;0
WireConnection;430;0;398;0
WireConnection;430;1;431;0
WireConnection;0;0;491;0
WireConnection;0;1;362;0
WireConnection;0;2;464;0
WireConnection;0;3;515;0
WireConnection;0;4;516;0
ASEEND*/
//CHKSM=2DA361837C3BFE35082A51EEB25F1E2E63720F9C