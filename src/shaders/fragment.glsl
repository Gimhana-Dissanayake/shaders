uniform vec3 u_color;

// A THREE.js Color translates to a vec3 type

void main() {

    gl_FragColor = vec4(u_color, 1.0);

}

// The fragment shader main function must set the value of gl_FragColor to a rgba format value.

// Each channel of a rgba format color takes a value between 0.0 and 1.0