interface Drawable{
  static ArrayList<Place> drawablePlaces = new ArrayList<Place>();
  static ArrayList<Transition> drawableTransitions = new ArrayList<Transition>();
  
  void draw();
  void registerDraw();
}
