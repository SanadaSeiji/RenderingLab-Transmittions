#version 330
//codes following:
//https://github.com/capnramses/antons_opengl_tutorials_book/tree/master/09_texture_mapping
//https://github.com/capnramses/antons_opengl_tutorials_book/tree/master/21_cube_mapping
//https://github.com/GuillaumeBouchetEpitech/GLSL-reflection-and-refraction/tree/master/res/shaders
//https://github.com/GuillaumeBouchetEpitech/GLSL-reflection-and-refraction/blob/master/res/shaders/glass.vert.glsl.c
//https://github.com/GuillaumeBouchetEpitech/GLSL-reflection-and-refraction/blob/master/res/shaders/glass.frag.glsl.c
//https://blog.demofox.org/2017/01/09/raytracing-reflection-refraction-fresnel-total-internal-reflection-and-beers-law/
//https://www.scratchapixel.com/lessons/3d-basic-rendering/introduction-to-shading/reflection-refraction-fresnel
//https://taylorpetrick.com/blog/post/dispersion-opengl


in vec3 position_eye, normal_eye;


uniform mat4 view;
uniform mat4 model;
uniform samplerCube cubeTex;


vec3 light_position_world  = vec3 (0.0, 5.0, 20.0);



out vec4 fragment_colour; // final colour of surface



void main () {


       //reflect ray around normal from eye to surface
       vec3 incident_eye = normalize (position_eye);
       vec3 normal = normalize (normal_eye);

       // ------------reflection-----------------------
       
       vec3 reflected = reflect (incident_eye, normal);

        reflected = vec3 (inverse (model) * inverse (view) * vec4 (reflected, 0.0));

       vec4 reflection = texture(cubeTex, reflected);

       //-----------------refraction--------------------
        
        float air = 1.0;
        float glass = 1.51714;
        float eta = air /glass;

        /*  
        // -------simple refraction-----------
	vec3 refracted = refract (incident_eye, normal, eta);

        refracted = vec3 (inverse (model) * inverse (view) * vec4 (refracted, 0.0));

        vec4 refraction = texture(cubeTex, refracted);
        */

        //--------chromatic dispersion--------

        float waveLengthR = 1.0/1.45;
        float waveLengthG = 1.0/1.50;
        float waveLengthB = 1.0/1.55;

        vec3 refractedR = refract (incident_eye, normal, eta * waveLengthR);
        vec3 refractedG = refract (incident_eye, normal, eta * waveLengthG);
        vec3 refractedB = refract (incident_eye, normal, eta * waveLengthB);

        refractedR = vec3 (inverse (model) * inverse (view) * vec4 (refractedR, 0.0));
        refractedG = vec3 (inverse (model) * inverse (view) * vec4 (refractedG, 0.0));
        refractedB = vec3 (inverse (model) * inverse (view) * vec4 (refractedB, 0.0));
 
        vec4 refraction;
        refraction.r = texture(cubeTex, refractedR).r;
        refraction.g = texture(cubeTex, refractedG).g;
        refraction.b = texture(cubeTex, refractedB).b;
        refraction.a = 1.0;

        //-----------------fresnel-------------------------------
         
        float R0 = ((air - glass) * (air - glass)) / ((air + glass) * (air + glass));

        float fresnel = R0 + (1.0 - R0) * pow( (1.0 - dot(-incident_eye, normal ) ), 5.0);

       

 
	// final colour

         fragment_colour = reflection;
        //fragment_colour = refraction;
        
	//fragment_colour = mix( refraction, reflection, fresnel );

}