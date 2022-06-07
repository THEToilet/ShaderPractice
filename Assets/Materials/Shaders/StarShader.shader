Shader "Unlit/StarShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            #define PI 3.1415926535

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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 st = 0.5 - i.uv;
                // atan2‚Ì•Ô‚è’l‚Í -PI ~ PI
                float a = atan2(st.y, st.x);
                //float d = abs(2 * sin(a + _Time.y)  + cos(a));
                //float d = abs(sin(a + _Time.y)) + 0.2;
                //float d = abs(min(sin(a + _Time.y),sin(a/2))) + 0.1;
                float d = abs(min(sin(a * 9 + _Time.z),cos(a * 9 + _Time.z))) * 0.4;
                // return (a + PI) / (2 * PI);
                //return d;
                float r = length(st);
                return step(r, d);
            }
            ENDCG
        }
    }
}
