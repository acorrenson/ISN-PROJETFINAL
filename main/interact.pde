void click(int w, int h) {
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {
      // les lignes paires sont décallées d'une demi largeur vers la droite:
      // NbPaire % 2 = 0
      int x = j * b.width + i%2 * (b.width/2) + b.width/2 + b.width/4;
      int y = i * (b.height/4) + b.height/2;
      
      if (dist(mouseX, mouseY, x, y) <= b.width/4) {
        println(j, i, dist(mouseX, mouseY, x, y));
        sx = j;
        sy = i;
        return;
      }
    }
  }
}