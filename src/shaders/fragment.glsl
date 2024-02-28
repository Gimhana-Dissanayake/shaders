uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec3 u_color;
uniform float u_time;

// A THREE.js Color translates to a vec3 type

varying vec2 v_uv;
varying vec3 v_position;

float rect(vec2 pt, vec2 size, vec2 center) {
    vec2 p = pt - center;
    vec2 halfsize = size * 0.5;

    float horz = step(-halfsize.x, p.x) - step(halfsize.x, p.x);
    float vert = step(-halfsize.y, p.y) - step(halfsize.y, p.y);

    return horz * vert;
}

float rect2(vec2 pt, vec2 anchor, vec2 size, vec2 center) {
    vec2 p = pt - center;
    vec2 halfsize = size * 0.5;
    float horz = step(-halfsize.x - anchor.x, p.x) - step(halfsize.x - anchor.x, p.x);
    float vert = step(-halfsize.y - anchor.y, p.y) - step(halfsize.y - anchor.y, p.y);
    return horz * vert;
}

mat2 getScaleMatrix(float scale) {
    return mat2(scale, 0, 0, scale);
}

mat2 getRotationMatrix(float theta) {
    float s = sin(theta);
    float c = cos(theta);
    return mat2(c, -s, s, c);
}

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

    // clamp enables to give maximum and minimum values
    /* 
    vec3 color = vec3(0);
    color.r = clamp(v_position.x, 0.0, 1.0);
    color.g = clamp(v_position.y, 0.0, 1.0);
    color.b = clamp(v_position.z, 0.0, 1.0);
    gl_FragColor = vec4(color, 1.0);
    */

    // Using step
    /*
      vec3 color = vec3(0.0);
    color.r = step(0.0, v_position.x);
    color.g = step(0.0, v_position.y);
    color.z = step(0.0, v_position.z);
    gl_FragColor = vec4(color, 1.0);
    */

    // Using smooth step
    // vec3 color = vec3(0.0);
    // color.r = smoothstep(0.0,0.1, v_position.x);
    // color.g = smoothstep(0.0,0.1, v_position.y);
    // color.z = smoothstep(0.0,0.1, v_position.z);
    // gl_FragColor = vec4(color, 1.0);

    // Drawing a circle
    /*
    float inCircle = 1.0 - step(0.5, length(v_position.xy));
    vec3 color = vec3(1.0, 1.0, 0.0) * inCircle;

    gl_FragColor = vec4(color, 1.0);
    */

    // Drawing a rectangle
    /*
    float inRect = rect(v_position.xy, vec2(1.0), vec2(0.0));
    vec3 color = vec3(1.0, 1.0, 0.0) * inRect;
    gl_FragColor = vec4(color, 1.0);
    */

// Drawing two squares
   /*float square1 = rect(v_position.xy, vec2(0.3), vec2(-0.5, 0.0));

    float square2 = rect(v_position.xy, vec2(0.4), vec2(0.5, 0.0));

    vec3 color = vec3(0.14, 0.53, 0.42) * square1 + vec3(0.0,1.0, 0.0) * square2;

    gl_FragColor = vec4(color, 1.0);
    */

    // Moving the shape
    /*
    float radius = 0.5;
    vec2 center = vec2(cos(u_time) * radius, sin(u_time) * radius);
    float square = rect(v_position.xy, vec2(0.5), vec2(center));
    vec3 color = vec3(1.0, 1.0, 0.0) * square;
    gl_FragColor = vec4(color, 1.0);
    */

    // Roating the shape
    /*
    vec2 center = vec2(0.0);
    mat2 mat = getRotationMatrix(u_time);
    vec2 pt = mat * v_position.xy;
    float inRect = rect(pt, vec2(0.5), center);
    vec3 color = vec3(1.0, 1.0, 0.0) * inRect;
    gl_FragColor = vec4(color, 1.0);
    */

    // Changing the rotation centre
    /*
    vec2 center = vec2(0.5, 0.0);
    mat2 matr = getRotationMatrix(u_time);
    mat2 mats = getScaleMatrix((sin(u_time) + 1.0)/ 3.0 + 0.5);
    vec2 pt = (mats * matr * (v_position.xy - center)) + center;
    float inRect = rect2(pt, vec2(0.15), vec2(0.3), center);
    vec3 color = vec3(1.0, 1.0, 0.0) * inRect;
    gl_FragColor = vec4(color, 1.0);
    */

    // Tiling
    /*    float tileCount = 6.0;
    vec2 center = vec2(0.5);
    mat2 mat = getRotationMatrix(u_time);
    vec2 p = fract(v_uv * tileCount);
    vec2 pt = (mat * (p - center)) + center;
    float inRect = rect(pt, vec2(0.5), center);
    vec3 color = vec3(1.0, 1.0, 0.0) * inRect;
    gl_FragColor = vec4(color, 1.0);
    */


}

// The fragment shader main function must set the value of gl_FragColor to a rgba format value.

// Each channel of a rgba format color takes a value between 0.0 and 1.0