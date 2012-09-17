cbuffer cbuf0
{
   float4 cool;
   int4 zeek;
   int2 arr[127];
};

sampler samp0;
sampler samp1;
Texture2D <float4> tex0;
TextureCube <float4> tex1;
Texture3D <float4> tex2;
Texture2DMS <float4,2> tex3;
Texture2D <float4> tex4[6];

float4 blah2( float4 cool )
{
   for ( int i = 0; i < (int)cool.x; i++ )
   {
      for ( int j = 0; j < (int)cool.y; j++ )
      {
         cool += tex0.SampleGrad( samp0, float2( i, j ), 1.5f, 4.1f );
      }
   }
   cool += cool + float4(1.1, 2.2, 3.3, 4.4);
   cool *= 55566.2;
  
   return cool;
}

float4 blah( float4 cool )
{

   for ( int i = 0; i < (int)cool.x; i++ )
   {
      for ( int j = 0; j < (int)cool.y; j++ )
      {
         cool += tex0.SampleGrad( samp0, float2( i, j ), 1.5f, 4.1f ) + blah2(cool);
      }
   }
   cool += cool + float4(1.1, 2.2, 3.3, 4.4);
      
   return cool;   
}

float4 main( 
   float4 t0 : TEXCOORD0,
   float4 t1 : TEXCOORD1_centroid,
   float4 p0 : SV_POSITION
   ) : SV_TARGET
{
   float j = (uint)p0.x + dot(t0, float4(0,1,2,3)) + t1.x + (zeek.y ^ 2);
   for ( int i = 0; i < 10; i++ )
   {
      j += i * (1.0f/(i+(1.001))) + sqrt( j );
      if (j < 0)
         break;
   }
   int q = (int)j;
   if ( q < 0 )
   {
      q ^= 50;
   }
   else if ( q > 5 )
   {
      q &= 2222;
   }
   else
   { 
      q -= arr[q];
   }
   
   j += cool.x + cool.y + cool.z + cool.w;
   j += tex0.Sample( samp0, float2( 0.125f, 5.0f ) ).x;
   j += tex0.Sample( samp1, float2( 0.777f, 1234.5f ) ).x;
   j += tex1.Sample( samp0, float3( 0.125f, 5.0f, 1.0 ) ).x;
   j += tex2.Sample( samp0, float3( 0.125f, 5.0f, 1.0 ) ).z;
   j += tex3.Load( int2( 0.125f, 5.0f ), 0, 1 ).x;
   j += tex0.SampleBias( samp0, float2( j, 1/j ), -15 ).y;

   j += tex4[0].Sample( samp0, int2( 0, 5 ) ).z;   
   j += tex4[1].Sample( samp0, int2( 0, 5 ) ).z;

   float x[8];
   float y[4];
   float z[4];
   
   y[3] = q;
   z[2] = q;
   y[2] = j;
   z[1] = j;
   q &= 556677;
   x[0] = q;
   z[0] = q;
   
   q |= 42;
   x[1] = q;
   z[3] = q;
   q >>= 76;
   y[1] = q;
   x[2] = q;
   q <<= 22;
   unsigned int qu = q;
   qu ^= q;
   x[3] = qu;
   y[0] = qu;
   qu >>= 3;
   x[4] = qu;
   qu <<= 2;
   x[5] = qu;
   qu ^= arr[qu];
   x[6] = qu;
   qu &= arr[qu & 127];
   x[7] = qu;
   j += arr[qu+66].y * arr[qu+1].x;
   x[7] += j;
         
   i += x[(int)q & 7];
   q += x[(int)i & 7];
   i += y[(int)q & 7];
   i += z[(int)q & 7];
      
   return float4(i,q,j*.2,qu + .5f) + blah( float4(i, q, j, qu));
}
