public class Bird{
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  ArrayList<PipePair> obstacles = new ArrayList();
  NeuralNetwork brain;

  int GRAVITY = 3;//3
  int dimension;
  int red;
  int green;
  int blue;

  public Bird(int x, int y,int dimension, int red, int green, int blue,
     ArrayList<PipePair> obstacles){
    this.position = new PVector(x,y);
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,GRAVITY);
    this.obstacles = obstacles;
    this.dimension = dimension;
    this.red = red;
    this.green = green;
    this.blue = blue;

    this.brain = new NeuralNetwork(4,3,1);


  }
  public Bird(int x, int y,int dimension, int red, int green, int blue,
     ArrayList<PipePair> obstacles, NeuralNetwork brain){
    this.position = new PVector(x,y);
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,GRAVITY);
    this.obstacles = obstacles;
    this.dimension = dimension;
    this.red = red;
    this.green = green;
    this.blue = blue;

    this.brain = brain;


  }


  public void update(){


    this.velocity.x += this.acceleration.x;
    this.velocity.y += this.acceleration.y;
    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;


    fill(red, green, blue);
    ellipse(position.x, position.y, dimension, dimension);
    PipePair nearest = checkNearestPipePair(obstacles);
    double[] inputs = {position.x, position.y, nearest.positionTop.x, nearest.positionTop.y};
    double[] output = brain.feedforward(inputs);
    if(output[0]==1){
      jump();
    }


  }

  public boolean isAlive(){
    PipePair nearest = checkNearestPipePair(obstacles);

    if((position.x>= nearest.positionTop.x) &&
    ((position.y- dimension/2 < nearest.positionTop.y) ||
    (position.y + dimension/2 > nearest.positionBottom.y))){

      return false;
    }

    return true;

  }

  public void jump(){
    this.velocity.x=0;
    this.velocity.y=0;
    this.velocity.y = -45;

  }

  public PipePair checkNearestPipePair(ArrayList<PipePair> pipes){
    PipePair nearest = pipes.get(1);
    int distance;
    int nearestDistance;

    for(PipePair p : pipes){
      nearestDistance = (int)(nearest.positionTop.x + nearest.PIPE_WIDTH - position.x);
      distance = (int)(p.positionTop.x + p.PIPE_WIDTH - position.x);
      if((distance < nearestDistance)&&(distance>0)){
        nearest = p;
      }

      stroke(30);
      //line(position.x, position.y, nearest.positionTop.x+nearest.PIPE_WIDTH, position.y);

    }
    return nearest;

  }





}
