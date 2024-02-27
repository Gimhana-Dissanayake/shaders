uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec3 u_color;
uniform float u_time;

// A THREE.js Color translates to a vec3 type

varying vec2 v_uv;

void main() {

    // vec3 color = vec3(u_mouse.x/ u_resolution.x,0.0,u_mouse.y/u_resolution.y);
    // an alternative method 
    /*
    vec2 v = u_mouse/u_resolution;
    vec3 color1 = vec3(v.x, 0.0, v.y)
    gl_FragColor = vec4(color1, 1.0);
    */

    // Changing the color with time
    // When we run this shader, remember the GPU is busyly calculating the value of the color for each pixel in the screen, often simultaneously working with dozons of pixels in the same time. It is doing all those pixels 60 times per second.
    /*
    vec3 color = vec3((sin(u_time) + 1.0)/2.0, 0.0, (cos(u_time) + 1.0)/ 2.0);
    gl_FragColor = vec4(color, 1.0);
    */

    // Blending colors to create gradients
    // In the mix function. The first two variables are the colors that we are mixing from and two. If mix(x, y, 0.0) then we will get the color x, If mix(x, y, 1.0) then we will get color y. 
    // vec2 uv = gl_FragCoord.xy / u_resolution;
    // vec3 color = mix(vec3(1.0, 0.0, 0.0), vec3(0.0, 0.0, 1.0), uv.x);
    // gl_FragColor = vec4(color, 1.0);

    vec3 color = vec3(v_uv.x, v_uv.y, 0.0);
    gl_FragColor = vec4(color, 1.0);

}

// The fragment shader main function must set the value of gl_FragColor to a rgba format value.

// Each channel of a rgba format color takes a value between 0.0 and 1.0