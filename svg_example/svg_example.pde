PShape shapes, weirdShape, square;

void setup() {
  size(600, 600);
  background(255);
  shapes = loadShape("shapes.svg");
  weirdShape = shapes.getChild("weirdShape");
  square = shapes.getChild("square");
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    background(255);
    shape(shapes, 0, 0);
    weirdShape.disableStyle();
    fill(random(255), random(255), random(255));
    noStroke();
    shape(weirdShape, 0, 0);
  }
}
