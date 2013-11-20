ArrayList<DataObjects> dataObjects = new ArrayList();

HashMap<String, DataBin> dataLabel = new HashMap();
HashMap<Float, DataBin> dataValue = new HashMap();

ArrayList<Float> dataValNums = new ArrayList();
float maxVal = 0;

DataBin bin;
Table myTable;

void setup() {
  size(600, 400);
  background(255);
  noStroke();
  smooth();
  colorMode(HSB, 360, 100, 100);
  
  loadData();

  for (int i = 0; i < dataObjects.size(); i++) {
    
    DataObjects dataob = dataObjects.get(i);

    if (dataob.dataValue > maxVal) maxVal = dataob.dataValue;

    float x = map(i, 0, dataObjects.size(), 0, width);
    float c = map(dataob.dataValue, 0, maxVal, 0, 360);
    float h = map(dataob.dataValue, 0, maxVal, 0, height);
    float y = height - h;
    float w = width/dataObjects.size() - 2;

    fill(c, 100, 100);
    rect(x, y, w, h);
  }
}

void loadData() {
  String[] rows = loadStrings("data.csv");

  for (int i = 0; i < rows.length; i++) {
    String[] cols = rows[i].split(",");

    DataObjects d = new DataObjects();
    d.dataLabel = cols[0];
    d.dataValue = float(cols[1]);

    dataObjects.add(d);
    
    println(d.dataLabel + ", " + d.dataValue);
  }
}

