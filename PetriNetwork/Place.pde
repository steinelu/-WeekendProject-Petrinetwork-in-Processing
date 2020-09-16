class Place extends Node implements Drawable{
  ArrayList<Transition> from = new ArrayList<Transition>();
  ArrayList<Transition> to = new ArrayList<Transition>();
  
  int tokens = 0;
  
  Place(int x, int y){
    center = new Point(x, y);
    registerDraw();
  }
  
  void mouseLeftActionEdit(){
    tokens++;
  }
  
  void mouseRightActionEdit(){
    if(tokens > 0)
      tokens--;
  }
  
  void mouseLeftAction(){}
  void mouseRightAction(){}
  
  void remove(){
    for(Transition t : from){
       t.removeFrom(this);
    }
    
    for(Transition t : to){
       t.removeTo(this);
    }
  }
  
  void removeFrom(Transition t){
    to.remove(t);
  }
  
  void removeTo(Transition t){
    from.remove(t);
  }

  void connectTo(Transition transitionTo){
    transitionTo.connectFrom(this);
    to.add(transitionTo);
  }
  
  void connectFrom(Transition transitionFrom){
    from.add(transitionFrom);
  }
  
  void draw(){
    ellipse(getX(), getY(), 20, 20);
    if(tokens == 1){
      fill(0);
      ellipse(getX(), getY(), 4, 4);
      fill(255);
    } else if(tokens > 1){
      fill(0);
      text(String.valueOf(tokens), getX() - 3, getY() + 5);
      fill(255);
    }
  }
  
  void registerDraw(){
    Drawable.drawablePlaces.add(this);
  }
  
  boolean hasToken(){
    return tokens > 0;
  }
  
  void decrementTokens(){
    if(tokens > 0)
      tokens--;
  }
  
  void incrementTokens(){
    tokens++;
  }
}
