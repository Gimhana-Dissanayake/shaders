varying vec2 v_uv;

void main() {
    v_uv = uv;
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}

// A vertex shader must set gl_Position for every vertex in the mesh.

// You need a vertex shader and a fragment shader and each of these must have a main function.

// The vertex shader main function must set the value of gl_Position and it uses the projectionMatrix, the modelViewMatrix and the position of the vertext to do this.