class Point{
  int x;
  int y;
  
  Point(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  Point(float x, float y){
    this.x = (int)x;
    this.y = (int)y;
  }
  
  boolean isInBound(Point p, int l){
    return isInBound(p.x, p.y, l);
  }
  
  boolean isInBound(int x_, int y_, int l){
    if(x_ < x + l &&
       x_ > x - l &&
       y_ < y + l &&
       y_ > y - l)
      return true;
     return false;
  }
  
  Point rotate(float angle){
    return new Point(cos(angle) * x - sin(angle) * y, sin(angle) * x + cos(angle) * y);
  }
  
  Point add(Point p){
    return new Point(x + p.x, y + p.y);
  }
  
  Point sub(Point p){
    return new Point(x - p.x, y - p.y);
  }
  
  void draw (){
    ellipse(x, y, 4, 4);
  }
  
  void debug(int l){
    line(x + l, y + l, x + l, y - l);
    line(x + l, y - l, x - l, y - l);
    line(x - l, y - l, x - l, y + l);
    line(x - l, y + l, x + l, y + l);
  }
}
