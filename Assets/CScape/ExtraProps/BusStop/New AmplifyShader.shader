// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CSRefraction"
{
	Properties
	{
		_Float1("Float 1", Range( 0 , 1)) = 0.292
		_TextureSample1("Texture Sample 1", 2D) = "bump" {}
		_Color0("Color 0", Color) = (0,0,0,0)
		_Texture0("Texture 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _GrabTexture;
		uniform float _Float1;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float4 _Color0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float3 tex2DNode3 = UnpackScaleNormal( tex2D( _TextureSample1, uv_TextureSample1 ) ,0.2 );
			o.Normal = tex2DNode3;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 screenColor2 = tex2D( _GrabTexture, ( (ase_screenPosNorm).xy + (( tex2DNode3 * _Float1 )).xy ) );
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode9 = tex2D( _Texture0, uv_Texture0 );
			o.Emission = ( screenColor2 * ( 1.0 - tex2DNode9.r ) * _Color0 ).rgb;
			o.Smoothness = tex2DNode9.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13901
174;433;1489;529;2249.915;-189.1623;1.857545;True;True
Node;AmplifyShaderEditor.RangedFloatNode;4;-1458.279,300.619;Float;False;Property;_Float1;Float 1;0;0;0.292;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;-1532.584,77.11963;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.2;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ScreenPosInputsNode;8;-1089.399,-101.2794;Float;False;0;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1149.978,161.0194;Float;False;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.ComponentMaskNode;7;-900.0847,-61.0804;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.ComponentMaskNode;6;-956.8845,158.8193;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.TexturePropertyNode;13;-1455.182,448.989;Float;True;Property;_Texture0;Texture 0;4;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.SimpleAddOpNode;1;-671.679,11.02013;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0.0,0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;9;-993.8118,441.1344;Float;True;Property;_dirt5;dirt5;2;0;Assets/Beautify/Resources/Textures/dirt5.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;11;-486.6174,226.839;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ScreenColorNode;2;-484.3036,-40.37968;Float;False;Global;_GrabScreen1;Grab Screen 1;-1;0;Object;-1;False;1;0;FLOAT2;0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;12;-324.2331,544.0956;Float;False;Property;_Color0;Color 0;3;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1252.414,753.8561;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT2;0;False;1;FLOAT2
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1623.923,839.3032;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-254.8795,117.1036;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;16;-1009.074,1101.217;Float;True;Property;_TextureSample4;Texture Sample 4;2;0;Assets/Beautify/Resources/Textures/dirt5.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-585.5548,651.691;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;55.89999,-19.5;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;CSRefraction;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;7;0;8;0
WireConnection;6;0;5;0
WireConnection;1;0;7;0
WireConnection;1;1;6;0
WireConnection;9;0;13;0
WireConnection;11;0;9;1
WireConnection;2;0;1;0
WireConnection;17;0;9;1
WireConnection;17;1;18;0
WireConnection;10;0;2;0
WireConnection;10;1;11;0
WireConnection;10;2;12;0
WireConnection;0;1;3;0
WireConnection;0;2;10;0
WireConnection;0;4;9;0
ASEEND*/
//CHKSM=70737B1A9179950D60FBC200EB609BB1F08EBEEE