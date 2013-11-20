class Person {
  String id;
  ArrayList<Person> links = new ArrayList();

  PVector pos = new PVector();
  PVector tpos = new PVector();

  int generation = 0;

  void update () {
    pos.x = lerp(pos.x, tpos.x, 0.1);
    pos.y = lerp(pos.y, tpos.y, 0.1);
  }

  void render () {
    pushMatrix();
    translate(pos.x, pos.y);
    rect(0, 0, 5, 5);
    fill(0);
    text(id, 10, 0);
    popMatrix();

    //Draw a line from this object to all of the links
    for (Person linkGuy:links) {
      stroke(0, 50);
      line(pos.x, pos.y, linkGuy.pos.x, linkGuy.pos.y);
    }
  }
}

