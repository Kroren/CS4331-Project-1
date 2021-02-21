int baseColor = #474747;

int margin = 10;
int centerX = 500;
int centerY = 750;

int keySize = 190; // Diameter of key
int keyCenter = keySize / 2;
int keySpacing = 20;
int rowCount = 0;

// Variable data setup
void setup() { // Draw the background UI
  size(1000, 1500);
  fill(baseColor);
  rect(margin, margin, 980, 1480, 7);
  // TIMER will be above
  line(10, 400, 990, 400); // BUTTONS will be drawn below this line
}

void createKeypad() {
   fill(#E8E8E8);
   int offsetX = 0; // count out the keys
   int offsetY = 650;
   int nCount = 9;
   for(int col = 0; col < 4; col++) {
      for (int row = 0; row < 3; row++) {
        offsetX += keySpacing;
        rect(offsetX, offsetY, keySize, keySize);
        text(nCount, keyCenter, keyCenter);
        // Move to the next
        nCount -= 1;
        offsetX += keySize;
      }
      offsetX = 0;
      offsetY += keySize + keySpacing;
   }
}

void draw() {
   createKeypad();
}
