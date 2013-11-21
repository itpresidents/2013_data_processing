//-----set up array lists for each candidate & position
ArrayList<Expenses> forObama = new ArrayList();
ArrayList<Expenses> againstObama = new ArrayList();
ArrayList<Expenses> forRomney = new ArrayList();
ArrayList<Expenses> againstRomney = new ArrayList();

//-----set up array lists for pac name bins
ArrayList<ExpenseBin> foList = new ArrayList();
ArrayList<ExpenseBin> aoList = new ArrayList();
ArrayList<ExpenseBin> frList = new ArrayList();
ArrayList<ExpenseBin> arList = new ArrayList();

//-----set up hash map for pac names
HashMap<String, ExpenseBin> foHash = new HashMap(); //new hash map, tell it what it's looking for
HashMap<String, ExpenseBin> aoHash = new HashMap();
HashMap<String, ExpenseBin> frHash = new HashMap();
HashMap<String, ExpenseBin> arHash = new HashMap();

PFont label;

PImage mitt;
PImage barack;

boolean detail;

float pacTotal = 0;

float foTotal = 0;
float aoTotal = 0;
float frTotal = 0;
float arTotal = 0;

void setup() {
  size(1280, 720);
  smooth();

  //load data and establish positions, colors, sizes of ellipses
  loadData();
  position();

  label = createFont("Futura-CondensedExtraBold", 19);
  textFont(label);

  mitt = loadImage("mitt.png");
  barack = loadImage("obama.png");

  detail = false;

  sum();


  //for debugging

  /*println("For Obama: " + forObama.size());
   println("Against Obama: " + againstObama.size());
   println("For Romney: " + forRomney.size());
   println("Against Romney: " + againstRomney.size());*/
}

void draw() {
  background(255);

  noStroke();
  fill(150, 175, 255, 150);
  rect(0, 0, width/2, height);
  fill(255, 150, 150, 150);
  rect(width/2, 0, width/2, height);

//  stroke(0);
//  line(width/2, 0, width/2, height);
  //line(0, height/2, width, height/2);
  
  imageMode(CENTER);
  image(mitt, 3 * (width/4), height/2);
  image(barack, width/4, height/2);
//  image(mitt, 4*(width/6)-20, height/4);
//  image(barack, width/6-20, height/4-10);

  if (detail == true) {
    fill(0, 0, 255);
    textAlign(CENTER);
    text("Super PACs supporting Obama", width/4, 20);
    text("Super PACs opposing Obama", width/4, height - 10);  //height - 10
    fill(255, 0, 50);
    text("Super PACs supporting Romney", 3*(width/4), 20);
    text("Super PACs opposing Romney", 3*(width/4), height - 10); // height - 10

    //render all ellipses to the screen
    for (ExpenseBin ex:foList) {
      ex.render();
      ex.update();
      ex.callName();
    }
    for (ExpenseBin ex:aoList) {
      ex.render();
      ex.update();
      ex.callName();
    }
    for (ExpenseBin ex:frList) {
      ex.render();
      ex.update();
      ex.callName();
    }
    for (ExpenseBin ex:arList) {
      ex.render();
      ex.update();
      ex.callName();
    }
  } 
  else {
    allPacs();
  }
}

//-----load & parse the data
void loadData() {
  String [] rows = loadStrings("expenses.csv");

  //establish strings of phrases to look for
  String obama = "OBAMA BARACK, Obama Barack, Obama Barak, Barak Obama, Barack Obama";
  String romney = "ROMNEY MITT, Romney Mitt, MITT ROMNEY, Mitt Romney";
  String support = "Support";

  for (int i = 1; i < rows.length; i++) {
    Expenses ex = new Expenses(); //create new expenses object for each row
    ex.fromCSV(rows[i].split(",")); //load CSV within object and split it
    //println(ex.candidate);
    String pac = ex.pacName;
    //println(pac);
    //separate the "obama" objects from everything else
    if (obama.indexOf(ex.candidate) != -1) {
      //println("got an Obama!");
      //separate the "support" objects from the "oppose" objects
      if (support.indexOf(ex.position) != -1) {
        forObama.add(ex); //add to the support array list
        //println("added!");
        if (foHash.containsKey(pac)) { //if super PAC bin already exists
          ExpenseBin bin = foHash.get(pac);
          bin.superPacs.add(ex);
          bin.total = bin.total + ex.amount;
        } 
        else { //otherwise create a new one
          ExpenseBin bin = new ExpenseBin();
          bin.pacName = pac;
          bin.superPacs.add(ex);
          foHash.put(pac, bin);
          foList.add(bin);
          bin.total = ex.amount;
          //println(pac);
        }
      } 
      else {
        againstObama.add(ex); //add to the oppose array list
        if (aoHash.containsKey(pac)) { //if super PAC bin already exists
          ExpenseBin bin = aoHash.get(pac);
          bin.superPacs.add(ex);
          bin.total = bin.total + ex.amount;
        } 
        else { //otherwise create a new one
          ExpenseBin bin = new ExpenseBin();
          bin.pacName = pac;
          bin.superPacs.add(ex); 
          aoHash.put(pac, bin);
          aoList.add(bin);
          bin.total = ex.amount;
          //println(pac);
        }
      }
    }

    //separate "romney" objects from everything else
    if (romney.indexOf(ex.candidate) != -1) {
      //println("ewwwww!");

      //separate "support" objects from everything else
      if (support.indexOf(ex.position) != -1) {
        forRomney.add(ex); //add to support array list
        if (frHash.containsKey(pac)) { //if super PAC bin already exists
          ExpenseBin bin = frHash.get(pac);
          bin.superPacs.add(ex);
          bin.total = bin.total + ex.amount;
        } 
        else { //otherwise create a new one
          ExpenseBin bin = new ExpenseBin();
          bin.pacName = pac;
          bin.superPacs.add(ex);
          frHash.put(pac, bin);
          frList.add(bin);
          bin.total = ex.amount;
          //println(pac);
        }
      } 
      else {
        againstRomney.add(ex); //add to oppose array list
        if (arHash.containsKey(pac)) { //if super PAC bin already exists
          ExpenseBin bin = arHash.get(pac);
          bin.superPacs.add(ex);
          bin.total = bin.total + ex.amount;
        } 
        else { //otherwise create a new one
          ExpenseBin bin = new ExpenseBin();
          bin.pacName = pac;
          bin.superPacs.add(ex);
          arHash.put(pac, bin);
          arList.add(bin);
          bin.total = ex.amount;
          //println(pac);
        }
      }
    }
  }
}

//-----establish positions, colors, sizes of ellipses using data from the hash maps
void position() {

  for (int i = 0; i < foList.size(); i++) {
    ExpenseBin bin = foList.get(i);

    bin.pos.x = width/2;
    bin.pos.y = height/2;
    
    //position at top left of screen
    bin.targetPos.x = random(10, width/2-10);
    bin.targetPos.y = random(40, height/4+10);  //(30, height/4 + 10)

    //color the ellipses blue
    //bin.collins = color(92,121,93);

    //map area of ellipses to amount of expense
    bin.d = map(sqrt(bin.total), sqrt(0), sqrt(18000000), 5, 30);
  }


  for (int i = 0; i < aoList.size(); i++) {
    ExpenseBin bin = aoList.get(i);

    bin.pos.x = width/2;
    bin.pos.y = height/2;
    
    //position at bottom left of screen
    bin.targetPos.x = random(10, width/2-20);
    bin.targetPos.y = random(3*(height/4)-20, height-35);

    //color the ellipses blue
    //bin.collins = color(255, 150);

    //map area of ellipses to amount of expense
    bin.d = map(sqrt(bin.total), sqrt(0), sqrt(18000000), 5, 30);
  }

  for (int i = 0; i < frList.size(); i++) {
    ExpenseBin bin = frList.get(i);

    bin.pos.x = width/2;
    bin.pos.y = height/2;
    //position at top left of screen
    //while (true)
    bin.targetPos.x = random(width/2 +20, width-20);
    bin.targetPos.y = random(30, height/4);

    //color the ellipses blue
    //bin.collins = color(255, 150);

    //map area of ellipses to amount of expense
    bin.d = map(sqrt(bin.total), sqrt(0), sqrt(18000000), 5, 30);
  }

  for (int i = 0; i < arList.size(); i++) {
    ExpenseBin bin = arList.get(i);

    bin.pos.x = width/2;
    bin.pos.y = height/2;
    //position at top left of screen
    bin.targetPos.x = random(width/2+20, width-20);
    bin.targetPos.y = random(3*(height/4), height-20);

    //color the ellipses blue
    //bin.collins = color(255,150);

    //map area of ellipses to amount of expense
    bin.d = map(sqrt(bin.total), sqrt(0), sqrt(18000000), 5, 30);
  }
}

void mousePressed() {

  detail = !detail;

  for (ExpenseBin bin:foList) {
    bin.pos.x = width/2;
    bin.pos.y = height/2;
  }

  for (ExpenseBin bin:aoList) {
    bin.pos.x = width/2;
    bin.pos.y = height/2;
  }

  for (ExpenseBin bin:frList) {
    bin.pos.x = width/2;
    bin.pos.y = height/2;
  }

  for (ExpenseBin bin:arList) {
    bin.pos.x = width/2;
    bin.pos.y = height/2;
  }
}

void sum() {

  for (ExpenseBin ex:foList) {
    foTotal = foTotal + ex.total;
  }
  for (ExpenseBin ex:aoList) {
    aoTotal = aoTotal + ex.total;
  }
  for (ExpenseBin ex:frList) {
    frTotal = frTotal + ex.total;
  }
  for (ExpenseBin ex:arList) {
    arTotal = arTotal + ex.total;
  }

  println (foTotal);
  println (aoTotal);
  println (frTotal);
  println(arTotal);

  pacTotal = foTotal + aoTotal + frTotal + arTotal;
}

void allPacs() {

  noStroke();
  //fill(92, 121, 93);
  fill(166,196,170);
  float totalD = map(sqrt(pacTotal), sqrt(0), sqrt(18000000), 5, 30);
  ellipse(width/2, height/2, totalD, totalD);
  fill(0);
  textAlign(CENTER);
  //text("$" + int(pacTotal), width/2, height/2);
  text("$" + "518,280,704", width/2, height/2 +7);
  text("TOTAL SUPER PAC DONATIONS", width/2, height/2 - 180);
  text("IN THE 2012 PRESIDENTIAL ELECTION", width/2, height/2 - 150);
}

