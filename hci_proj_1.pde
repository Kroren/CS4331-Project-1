int baseColor = #474747;

int margin = 10;
int centerX = 500;
int centerY = 750;

int keyX, keyY; // Keypad key dimension
int keySize = 150; // Diameter of key

// Variable data setup
void setup() { // Draw the background UI
  size(1000, 1500);
  fill(baseColor);
  rect(margin, margin, 980, 1480, 7);
  // TIMER will be above
  line(10, 400, 990, 400); // BUTTONS will be drawn below this line
}

void draw() {
  
}
