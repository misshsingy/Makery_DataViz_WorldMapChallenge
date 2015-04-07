///// variables Libraries
// LIBRARIES
import processing.pdf.*;



//number
int myNumber; //creating a variable of type int
float latitude;
String forText;

int [] arrayInt = {1,2,3};
String[] names = {"nelson","jon","hsing"};
int [][] dataMatrix = {
{1,2,3},
{4,5,6},
{7,8,9}
};

//variable to load the map
PShape baseMap;
//variable for data import
String csv[];
String splitData[][];//creating a 2D array

PFont f;


// setup
void setup (){
  noLoop(); //this is to do only ONE draw loop
  f = createFont("Avenir-Medium", 12);
  
  size(1600,800); //width is 2xheight
  baseMap = loadShape("WorldMap.svg"); //this load the graphic
  csv = loadStrings("MeteorStrikesSmall.csv");//this loads the csv file
  splitData = new String[csv.length][6];// x number of rows and 6 columns
  //split the data on each row and save it independently
  for(int i=0; i<csv.length; i++){
    splitData [i] = csv[i].split(",");
  }
  
  //println("number of rows imported !!!:   " + csv.length);
  println(splitData[3][3] + " longitude " + splitData[3][4] + " latitude ");
  frameRate(90);
}

//draw
void draw(){
  beginRecord(PDF, "meteorStrikes.pdf");
  shape(baseMap, 0, 0, width, height); // draws the map

  //go through the 2d array to plot the data
  for(int i=0; i<csv.length; i++){
    textMode(MODEL);
    //mapping from sphere info to flat 2d info
    float longitude = map(float(splitData[i][3]),-180,180,0,width); //mapping latitude
    float latitude = map(float(splitData[i][4]),90,-90,0,height);
    
    //for the size
    float markerSize = (sqrt(float(splitData[i][2])) / PI ) * 0.05; //0.05 is randomly picked to your taste
    noStroke();
    fill (16,83,175,100);
    ellipse(longitude,latitude, markerSize,markerSize);
    
    //labels
      if(i < 50){
        textFont(f);
        text(splitData[i][0],longitude,latitude);
      }
  }
  endRecord(); //we finish constructing the pdf
  println("PDF Saved!");
}
