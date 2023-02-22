Shader "Example/SimpleColor" // Nombre que va a tener en Unity
{
    Properties //Las propiedades del Shader (Como las que se muestran en el ShaderGraph)
    {
        _Color("Main Color" , Color) = (1,1,1,1)
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

            struct Attributes
            {
                float4 positionOS : POSITION;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
            };

            float4 _Color;

            Varyings vert(Attributes IN)
            {
                float4 positionNDC = TransformObjectToHClip(IN.positionOS);
               Varyings OUT;
                OUT.positionHCS = positionNDC;
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                return  _Color;
            }
            ENDHLSL
        }
    }
}