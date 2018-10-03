
ArrayList<Bird> agents = new ArrayList();
ArrayList<PipePair> pipes = new ArrayList();
ArrayList<Bird> agentsDisposal = new ArrayList();
ArrayList<PipePair> pipesDisposal = new ArrayList();

Bird chosen = new Bird(width/2, (int)random(200,width-200), 200,
(int)random(0,256), (int)random(0,256), (int)random(0,256), pipes);

int generationCounter = 0;
double score = 0;
double maxScore = 0;
double averageScore =0;
double sumScore =0;

int tubesOffset=50;


void setup(){


  textSize(200);

  frameRate(100);
  agents = new ArrayList();
  pipes = new ArrayList();
  agentsDisposal = new ArrayList();
  pipesDisposal = new ArrayList();

  size(3000,1800);


  if(generationCounter == 0){
    randomGeneration(4000);
  }else{
    newGeneration(chosen,200,0.05);
  }
  for(int i = 0; i<6; i++){

    PipePair p = new PipePair(width+tubesOffset,
      (int)random(height/7,height+1-height/7),
    (int)random(500,600+1),255,0,0);
    pipes.add(p);
    tubesOffset += 1200;
  }
  tubesOffset = 0;

  if(score > maxScore){
    maxScore = score;
  }
  generationCounter ++;

  averageScore = (averageScore*(generationCounter-1)+score)/(generationCounter);


  score = 0;
  System.out.println("IH W:");
  chosen.brain.weights_ih.print();
  System.out.println("H B:");
  chosen.brain.bias_h.print();
  System.out.println("HO W:");
  chosen.brain.weights_ho.print();
  System.out.println("O B:");
  chosen.brain.bias_o.print();
}



void draw(){
  background(125,125,255);


  for(Bird a: agents){

    a.update();
    if(!a.isAlive()){
      agentsDisposal.add(a);
    }
  }

  if(agents.size()==1){
    chosen=agents.get(0);

  }

  for(PipePair p : pipes){
    p.update();
    if(!p.isAlive()){
      pipesDisposal.add(p);
    }
  }

  if(pipes.size()==2){
    pipesGenerator();
  }

  if(agents.size()==0){
    setup();

  }



  if(agents.size()==0){
    System.out.println("no chosen");

  }


  removeTrash();


score+=0.5;

String status = ("generation :"+generationCounter+'\n'+"score: "+score+'\n'+"maxScore: "+maxScore+'\n'+"averageScore: "+averageScore);
fill(255,255,0);
text(status, 20, 300);




}



void newGeneration(Bird generator, int number, double mutationRate){
    Bird generatorCopy = new Bird(width/7, (int)random(200,width-200), 200,
     (int)random(0,256), (int)random(0,256), (int)random(0,256), pipes, generator.brain.copy());
    agents.add(generatorCopy);
    for(int i = 0; i<number; i++){
      NeuralNetwork b = generator.brain.copy();
      b.mutate(mutationRate);
      agents.add(new Bird(width/7, (int)random(200,width-200), 200,
       (int)random(0,256), (int)random(0,256), (int)random(0,256), pipes, b));
    }


  }

  void randomGeneration(int number){
    for(int i = 0; i<number; i++){
    NeuralNetwork brain = new NeuralNetwork(4,3,1);
    agents.add(new Bird(width/7, (int)random(200,width-200), 200,
    (int)random(0,256), (int)random(0,256), (int)random(0,256), pipes, brain));
 }


}
void pipesGenerator(){


    PipePair p = new PipePair(width+tubesOffset,
      (int)random(height/10,height+1-height/10),
    (int)random(600,700+1),255,0,0);
    pipes.add(p);

  }


void removeTrash(){

  for(PipePair p : pipesDisposal){

    pipes.remove(p);


  }



  for(Bird a:agentsDisposal){

    agents.remove(a);
  }

  pipesDisposal = new ArrayList();
  agentsDisposal = new ArrayList();

}


/*
IH W:

 -0.2767660610236464  0.7579446069729354  -0.5114333541953591  -0.7705322599022748
 -0.31702739702207006  -0.902068357272056  0.25773922378868486  0.352151827535498
 -0.5993171011659706  -0.7233637571191078  -0.21478370467922492  -0.4217950558532586
H B:

 0.358195065143057
 0.15919488743030197
 0.8082634563376372
HO W:

 0.7952766669939262  -0.4076420477226168  0.4224833259973739
O B:

 -0.46677383051084 */
