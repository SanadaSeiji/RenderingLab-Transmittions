#version 330
//codes following:
//https://github.com/capnramses/antons_opengl_tutorials_book/tree/master/09_texture_mapping
//https://github.com/GuillaumeBouchetEpitech/GLSL-reflection-and-refraction/blob/master/res/shaders/glass.frag.glsl.c
//https://blog.demofox.org/2017/01/09/raytracing-reflection-refraction-fresnel-total-internal-reflection-and-beers-law/

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

       vec3 reflected = reflect (incident_eye, normal);

       // convert from eye to world space
        


        reflected = vec3 (inverse (view) * vec4 (reflected, 0.0));

        vec4 reflection = texture(cubeTex, reflected);
       

 
	// final colour
        
	fragment_colour = reflection;

}