ArrayList<Node> nodes = new ArrayList<Node>();

abstract class Node{
  Point center;
  boolean dragging = false;
  int w = 20;
  Point temp;
  
  abstract void mouseLeftActionEdit();
  abstract void mouseRightActionEdit();
  abstract void mouseLeftAction();
  abstract void mouseRightAction();
  abstract void remove();
  
  Node(){
    nodes.add(this);
  }
  
  Point getPoint(){return center;}
  int getX(){return center.x;}
  int getY(){return center.y;}
  
  void mousePressedEdit(){
    if(center.isInBound(mouseX, mouseY, w)){
      if(mouseButton == RIGHT){
        mouseRightActionEdit();
      } else if (mouseButton == CENTER){
        dragging = true;
      } else if (mouseButton == LEFT){
        temp = new Point(mouseX, mouseY);
        mouseLeftActionEdit();
      }
    }
  }
  
  void mousePressed(){
    if(center.isInBound(mouseX, mouseY, w)){
      if(mouseButton == RIGHT){
        mouseRightAction();
      } else if (mouseButton == CENTER){
        //dragging = true;
      } else if (mouseButton == LEFT){
        mouseLeftAction();
      }
    }
  }
  
  void mouseDragged(){
    if(dragging){
      center.x = mouseX;
      center.y = mouseY;
    }
    if(temp != null){
      temp.x = mouseX;
      temp.y = mouseY;
    }
  }
  
  void mouseReleased(){
    if(dragging)
      dragging = false;
    if(temp != null){
      for(Node node : nodes){
        if(node.center.isInBound(temp, 20)){
          // not nice but ... easy?
          if(node instanceof Place){
            if(this instanceof Transition){
              ((Transition)this).connectTo((Place)node);
            }
          } else if(node instanceof Transition){
            if(this instanceof Place){
              ((Place)this).connectTo((Transition)node);
            }
          }
        }
      }
      temp = null;
    }
  }
}
