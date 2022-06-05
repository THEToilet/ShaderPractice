Shader "Unlit/DistanceFieldShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float d = distance(float2(0.5, 0.5), i.uv);
				/*
				// âEÇ™ç∂à»è„Ç»ÇÁÇŒ1,ç∂Ç™ëÂÇ´ÇØÇÍÇŒ0
				float a = abs(sin(_Time.y / 3)) * 0.4;
				return step(a, d);
				*/

				// ÉOÉç
				// return step(abs(sin(d * 100 * _Time.y)), 0.5);
				//return step(abs(sin(d * 30)), abs(sin(_Time.y)));
				return step(abs(sin(d * 20 - _Time.y)), 0.2);
			}
		ENDCG
		}
	}
}
