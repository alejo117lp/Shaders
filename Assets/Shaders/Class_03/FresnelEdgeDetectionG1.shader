Shader "Example/FresnelEdgeDetectionG1"
{
    Properties //Nos permite crear las propiedades del material
    { 
        _MainTex("Main Texture", 2D) = "white"{} //Definimos la textura
        _Color("Edge Color", Color) = (0,0,0,1)
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalRenderPipeline" }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"            

            struct Attributes //Guarda los datos de la maya
            {
                float4 positionOS   : POSITION; //Guarda la posición del vertice
                float2 uv          : TEXCOORD0; // Guarda las UVs
            };

            struct Varyings
            {
                float4 positionHCS  : SV_POSITION;
                float2 uv         : TEXCOORD0;
            };

            //Aqui declaramos de nuevo las variables:

            sampler2D _MainTex; //Sampler nos permites saber sobre la textura y sobre su wrapmode, midmaps, etc
            float4 _Color;

            Varyings vert(Attributes IN) //Vertex Shader: Hace la rasterización 
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target//Fragment Shader: Muestra el pixel en pantalla.
            {
                return tex2D(_MainTex,IN.uv);
                //return _Color;
            }
            ENDHLSL
        }
    }
}