public class PipePair{

  PVector positionTop = new PVector();
  PVector positionBottom = new PVector();
  int pipeCenter_height;
  int pipeHole_dimension;
  int red;
  int green;
  int blue;
  int VELOCITY=20; // suggested value 20
  int PIPE_WIDTH=300;



  PipePair(int distance, int pipeCenter_height, int pipeHole_dimension,
     int red, int green, int blue ){

       this.pipeCenter_height = pipeCenter_height;
       this.pipeHole_dimension = pipeHole_dimension;
       this.red = red;
       this.green = green;
       this.blue = blue;

       this.positionTop.x = distance;
       this.positionBottom.x = distance;
       this.positionTop.y = pipeCenter_height - pipeHole_dimension/2;
       this.positionBottom.y = pipeCenter_height + pipeHole_dimension/2;
     }

  public void update(){

    positionTop.x -= VELOCITY;
    positionBottom.x -= VELOCITY;
    fill(red, green, blue);
    rect(this.positionTop.x, this.positionTop.y, PIPE_WIDTH,  -height);
    rect(this.positionBottom.x, this.positionBottom.y, PIPE_WIDTH, +height);


  }

  public boolean isAlive(){

    return (positionTop.x + PIPE_WIDTH >=0);

  }







}
