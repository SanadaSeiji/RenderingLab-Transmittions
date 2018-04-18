#version 330
//codes following:
//https://github.com/capnramses/antons_opengl_tutorials_book/tree/master/09_texture_mapping
//https://github.com/GuillaumeBouchetEpitech/GLSL-reflection-and-refraction/tree/master/res/shaders
//https://github.com/GuillaumeBouchetEpitech/GLSL-reflection-and-refraction/blob/master/res/shaders/glass.frag.glsl.c
//https://blog.demofox.org/2017/01/09/raytracing-reflection-refraction-fresnel-total-internal-reflection-and-beers-law/
//https://www.scratchapixel.com/lessons/3d-basic-rendering/introduction-to-shading/reflection-refraction-fresnel


in vec3 position_eye, normal_eye;
in vec2 tex_coordi;

uniform mat4 view;
uniform samplerCube cubeTex;


vec3 light_position_world  = vec3 (0.0, 5.0, 20.0);



out vec4 fragment_colour; // final colour of surface



void main () {


       //reflect ray around normal from eye to surface
       vec3 incident_eye = normalize (position_eye);
       vec3 normal = normalize (normal_eye);

       // convert from eye to world space
        
        float ratio = 1.0 /1.3333;
	vec3 refracted = refract (incident_eye, normal, ratio);

        refracted = vec3 (inverse (view) * vec4 (refracted, 0.0));

        vec4 refraction = texture(cubeTex, refracted);
       

 
	// final colour
        
	fragment_colour = refraction;

}