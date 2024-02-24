uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec3 u_color;

// A THREE.js Color translates to a vec3 type

void main() {

    // vec3 color = vec3(u_mouse.x/ u_resolution.x,0.0,u_mouse.y/u_resolution.y);
    // an alternative method 
    vec2 v = u_mouse/u_resolution;
    vec3 color1 = vec3(v.x, 0.0, v.y)
    gl_FragColor = vec4(color1, 1.0);



}

// The fragment shader main function must set the value of gl_FragColor to a rgba format value.

// Each channel of a rgba format color takes a value between 0.0 and 1.0