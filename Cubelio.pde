/****************************************************
  Time-Waster 2000
  
  UI:
   f - toggle fill
   c - toggle autorotation or PeasyCam
   d - toggle cube size variation

****************************************************/
import peasy.PeasyCam;
PeasyCam cam;
float    offset = 0;     // varies rotation in autorotate mode
float    space  = 50;    // center-to-center cube spacing
boolean  fill   = true;  // 'f' toggles cube fill
boolean  pcam   = false; // 'c' toggles autocam vs PeasyCam
boolean  fade   = true;  // 'd' toggles cube size variation
                         //    true:  size proportional to camera distance from center
                         //    false: size proportional to cube distance from center
                         
void setup() {
  //size(800, 800, P3D);
  fullScreen(P3D);
}

void draw() {
  translate(width/2, height/2);
  colorMode(RGB,255);
  background(16,0,48);
  lights();
  if (!pcam) {
    // set up and move the camera
    float dist = 300*(sin(offset)+1);
    camera(0, 0, dist, 0, 0, 0, 0, 1, 0);
    rotateX(offset);
    rotateY(offset/3);
    rotateZ(sin(offset));
  }
  
  // make 3D grid
  float num = 5;
  for (float x=-num;x<=num;x++) {
    for (float y=-num;y<=num;y++) {
      for (float z=-num;z<=num;z++) {
        color clr = color((x+num)*25 , (y+num)*25, (z+num)*25);
        stroke(clr);
        if (fill) {
          fill(clr,25);
        }
        else {
          noFill();
        }
        pushMatrix();
        translate(x * space, y * space, z * space);
        box(3 * sqrt(x*x+y*y+z*z) * (fade ? sin(offset)+1 : 1));
        popMatrix();
      }
    }
  }
  offset+=0.01;
}

void nmouseClicked() {
exit();
}
void keyPressed() {
  switch (keyCode) {
    case  70: // 'f': toggle fill
      fill = !fill;
      break;
    case  67: // 'c': toggle camera
      pcam = !pcam;
      if (pcam) {
        cam = new  PeasyCam(this, width/2, height/2, 0, 200);
      }
      else {
        cam = null;
      }
      break;
    case  68: // 'd': toggle cube size fade
      fade = !fade;
      break;
    default:
      //println(keyCode);
      break;
  }
}
