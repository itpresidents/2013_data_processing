class Expenses {
  String candidate; //candidate name
  float amount; //amount of donation
  String position; //support or oppose
  String pacName; //super PAC name
  
  //-----define variables for desired pieces of the data
  void fromCSV(String [] input) {
    candidate = input[1];
    pacName = input[3];
    amount = float(input[9]); //convert string to float
    position = input[12];
  }
}
