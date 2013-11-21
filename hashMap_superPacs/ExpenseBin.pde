//sort super PACs into this

class ExpenseBin implements Comparable {

  String pacName;
  ArrayList<Expenses> superPacs = new ArrayList();

  float total;

  PVector pos = new PVector(); //position of ellipse
  PVector targetPos = new PVector();
  float d; //diamater of ellipse

  float a; //alpha value

  int compareTo(Object o) {

    int r = superPacs.size() - ((ExpenseBin) o).superPacs.size();

    return(r);
  }

  //-----render data to screen
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(92, 121, 93, a);
    ellipse(0, 0, d, d);
    popMatrix();
  }

  void update() {
    pos.lerp(targetPos, 0.1);
  }


  void callName() {
    if (mouseX <= pos.x + d/2 && mouseX >= pos.x-d/2 && mouseY <= pos.y + d/2 && mouseY >= pos.y-d/2) {
      a = 255;
      fill(0);
      if (mouseX >= width/2) {
        textAlign(RIGHT);
      } 
      else {
        textAlign(LEFT);
      }
      text(pacName+", $"+int(total), mouseX+10, mouseY+35);
      //println(pacName + ", $" + int(total));
    } 
    else {
      a = 150;
    }
  }
}

