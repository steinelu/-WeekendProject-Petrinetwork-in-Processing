int sizeX = 480;
int sizeY = 360;

boolean editMode = false;

void setup(){
  size(480, 360);
  test();
}

void test(){
  Transition t1 = new Transition(75, 100);
  Transition t2 = new Transition(75, 300);
  Transition t3 = new Transition(225, 100);
  Transition t4 = new Transition(225, 300);
  
  Place p1 = new Place(50, 200);
  Place p2 = new Place(100, 200);
  Place p3 = new Place(150, 200);
  Place p4 = new Place(200, 200);
  Place p5 = new Place(250, 200);
  
  p1.connectTo(t1);
  t1.connectTo(p2);
  p2.connectTo(t2);
  t2.connectTo(p1);
  
  p3.connectTo(t1);
  t2.connectTo(p3);
  p3.connectTo(t3);
  t4.connectTo(p3);
  
  p4.connectTo(t4);
  t3.connectTo(p4);
  p5.connectTo(t3);
  t4.connectTo(p5);
  
  p2.incrementTokens();
  p5.incrementTokens();
}

void draw(){
  background(200, 200, 200);
  if(editMode){
    fill(0);
    text("edit mode active", 10, 10);
    fill(255);
  }
  //draw Edges first
  for(Place place : Drawable.drawablePlaces){
    for(Transition transition : place.to){
      drawArrow(place.center, transition.center);
    }
    if(place.temp != null){
      drawArrow(place.center, place.temp);
    }
  }
  
  for(Transition transition : Drawable.drawableTransitions){
    for(Place place  : transition.to){
      drawArrow(transition.center, place.center);
    }
    if(transition.temp != null){
      drawArrow(transition.center, transition.temp);
    }
  }
  
  //draw nodes
  
  for(Place place : Drawable.drawablePlaces){
    place.draw();
    //place.center.debug(20);
  }
  
   for(Transition transition : Drawable.drawableTransitions){
    transition.draw();
    //transition.center.debug(20);
  }
}

void drawArrow(Point a, Point b){
  line(a.x, a.y, b.x, b.y);
  int w = 13;
  
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  
  float l = sqrt(dx*dx + dy*dy);
  
  float x_ = b.x - (dx/l)*w;
  float y_ = b.y - (dy/l)*w;
  
  Point n = new Point((dx/l)*w/2, (dy/l)*w/2);
  Point p = new Point((int)x_, (int)y_);
  Point a1 = n.rotate(-PI*1.2).add(p);
  Point a2 = n.rotate(PI*1.2).add(p);
  
  drawLine(a1, p);
  drawLine(a2, p);
}

void drawLine(Point a, Point b){
  line(a.x, a.y, b.x, b.y);
}

void mousePressed(){
  for(Node node : nodes){
    if(editMode){
      node.mousePressedEdit();
    } else {
      node.mousePressed();
    }
  }
}

void mouseDragged(){
  for(Node node : nodes){
    node.mouseDragged();
  }
}

void mouseReleased(){
  for(Node node : nodes){
    node.mouseReleased();
  }
}

void keyPressed(){
  println(key);
  if(isMouseInBound() && editMode){
    if(key == 't'){
      new Transition(mouseX, mouseY);
    } else if(key == 'p'){
      new Place(mouseX, mouseY);
    } else if(key == 'x'){
      Node del = null;
      for(Node node : nodes){
        if(node.center.isInBound(mouseX, mouseY, 20)){
          node.remove();
          del = node;
        }
      }
      if(del != null){
        nodes.remove(del);
        Drawable.drawablePlaces.remove(del);
        Drawable.drawableTransitions.remove(del);
      }
    }
  }
  if(key == 'e' && isMouseInBound()) {
    editMode = !editMode;
  }
}

boolean isMouseInBound(){
  return (mouseX > 0 && mouseX < sizeX && mouseY > 0 && mouseY < sizeY)? true : false;
}
