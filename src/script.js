import * as THREE from "three";
import gsap from "gsap";
import GUI from "lil-gui";
import vertexShader from "./shaders/vertex.glsl";
import fragmentShader from "./shaders/fragment.glsl";

/**
 * Debug
 */

const gui = new GUI({
  width: 300,
  title: "Gimhana debug UI",
  closeFolders: false,
});
gui.close();
// gui.hide();

window.addEventListener("keydown", (event) => {
  if (event.key == "h") {
    gui.show(gui._hidden);
  }
});

/**
 * Base
 */
// Canvas
const canvas = document.querySelector("canvas.webgl");

// Scene
const scene = new THREE.Scene();

/**
 * Object
 */

const geometry = new THREE.PlaneGeometry(2,2);

// uniforms can be used to pass values from the control program to our shaders
const uniforms = {
  u_time:{value: 0.0},
  u_mouse:{value:{x:0.0, y:0.0}},
  u_resolution:{value:{x:0.0, y:0.0}},
  u_color: {value: new THREE.Color(0xff0000)},
};

// You will see a red cube. This is the default result that the three.js library returns if you do not pass any parameters, when creating new shader material

// Each uniform will store a common value for each vertx and pixel
const material = new THREE.ShaderMaterial({
  uniforms: uniforms,
  vertexShader: vertexShader,
  fragmentShader: fragmentShader,
});
const mesh = new THREE.Mesh(geometry, material);
scene.add(mesh);

/**
 * Sizes
 */
const sizes = {
  width: window.innerWidth,
  height: window.innerHeight,
};

window.addEventListener("resize", () => {
  const aspectRatio = window.innerWidth/window.innerHeight;
  let width, height;
  if (aspectRatio>=1){
    width = 1;
    height = (window.innerHeight/window.innerWidth) * width;
    
  }else{
    width = aspectRatio;
    height = 1;
  }
  camera.left = -width;
  camera.right = width;
  camera.top = height;
  camera.bottom = -height;
  camera.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight );
  uniforms.u_resolution.value.x = window.innerWidth;
  uniforms.u_resolution.value.y = window.innerHeight;
  
});

/**
 * Camera
 */
// Base camera
const camera = new THREE.OrthographicCamera( -1, 1, 1, -1, 0.1, 10 );
camera.position.z = 1;
scene.add(camera);

/**
 * Renderer
 */
const renderer = new THREE.WebGLRenderer({
  canvas: canvas,
});
renderer.setSize(window.innerWidth, window.innerHeight );
// renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));

/**
 * Animate
 */
const clock = new THREE.Clock();

const tick = () => {
  const elapsedTime = clock.getElapsedTime();

  // Render
  renderer.render(scene, camera);
  
  uniforms.u_time.value = elapsedTime;

  // Call tick again on the next frame
  window.requestAnimationFrame(tick);
};

tick();


// FUNCTIONS

const onWindowResize = () => {
  const aspectRatio = window.innerWidth/window.innerHeight;
  let width, height;
  if (aspectRatio>=1){
    width = 1;
    height = (window.innerHeight/window.innerWidth) * width;
    
  }else{
    width = aspectRatio;
    height = 1;
  }
  camera.left = -width;
  camera.right = width;
  camera.top = height;
  camera.bottom = -height;
  camera.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight );
  uniforms.u_resolution.value.x = window.innerWidth;
  uniforms.u_resolution.value.y = window.innerHeight;
}

const move = (evt) =>{
  uniforms.u_mouse.value.x = (evt.touches) ? evt.touches[0].clientX : evt.clientX;
  uniforms.u_mouse.value.y = (evt.touches) ? evt.touches[0].clientY : evt.clientY;
}

// EVENT LISTNERS
if('ontouchstart' in window){
  document.addEventListener('touchmove', move)
}else{
  window.addEventListener('resize',onWindowResize )
  document.addEventListener('mousemove',move)
}

// ON LOAD
window.onload = () => {
  onWindowResize()
}