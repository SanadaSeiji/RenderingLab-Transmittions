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

layout (location = 0) in vec3 vertex_position;

layout (location = 1) in vec3 vertex_normals;

layout (location = 2) in vec2 uv;



//light need to be able to move/change colour
uniform mat4 view;
uniform mat4 proj;
uniform mat4 model;

out vec3 position_eye, normal_eye;
out vec2 tex_coordi;



void main () {

//raising everything to eye_space
//later useful in fragment shader
	position_eye = vec3 (view * model * vec4 (vertex_position, 1.0));

	normal_eye = vec3 (view * model * vec4 (vertex_normals, 0.0));

        tex_coordi = uv;

	gl_Position = proj * vec4 (position_eye, 1.0);

}