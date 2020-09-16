class Transition extends Node implements Drawable{
  ArrayList<Place> from = new ArrayList<Place>();
  ArrayList<Place> to = new ArrayList<Place>();
  
  Transition(int x, int y){
    center = new Point(x, y);
    registerDraw();
  }
  
  void mouseLeftActionEdit(){}
  void mouseRightActionEdit(){}
  
  void mouseLeftAction(){
    // do a transition
    boolean transitionAllowed = true;
    for(Place place : from){
      if(!place.hasToken())
        transitionAllowed = false;
    }
    
    if(transitionAllowed || from.size() <= 0){
      for(Place place : from){
        place.decrementTokens();
      }
      
      for(Place place : to){
        place.incrementTokens();
      }
    } else {
    
    }
  }
  
  void mouseRightAction(){}
  
   void remove(){
    for(Place p : from){
       p.removeFrom(this);
    }
    
    for(Place p : to){
       p.removeTo(this);
    }
  }
  
  void removeFrom(Place p){
    to.remove(p);
  }
  
  void removeTo(Place p){
    from.remove(p);
  }

  
  void connectTo(Place placeTo){
    placeTo.connectFrom(this);
    to.add(placeTo);
  }
  
  void connectFrom(Place placeFrom){
    from.add(placeFrom);
  }
  
  void draw(){
    int w = 20;
    rect(getX()-w/2, getY() -w/2, w, w);
  }
  
  void registerDraw(){
    Drawable.drawableTransitions.add(this);
  }
}
