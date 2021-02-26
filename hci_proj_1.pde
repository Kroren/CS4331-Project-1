import controlP5.*;

ControlP5 cp5;

int baseColor = #474747;

int margin = 10;
int centerX = 500;
int centerY = 750;

int keySize = 190; // Diameter of key
int keyCenter = keySize / 2;
int keySpacing = 20;

/* 1 2 3
   4 5 6
   7 8 9
   C 0 + */
// 12 keys, 11 = 0

// Variable data setup
void setup() { // Draw the background UI
  cp5 = new ControlP5(this);

  size(1000, 1500);
  fill(baseColor);
  rect(margin, margin, 980, 1480, 7);
  // TIMER will be above
  line(10, 400, 990, 400); // BUTTONS will be drawn below this line
  
  createKeypad(); // Create the keypad
}

void draw() {
  background(0);
}

// Control the functions of the keys
void controlEvent(CallbackEvent event) {
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    switch(event.getController().getAddress()) {
      case "/1":
        println("Button 1 pressed");
        break;
      case "/2":
        println("Button 2 pressed");
        break;
      case "/3":
        println("Button 3 pressed");
        break;
      case "/4":
        println("Button 4 pressed");
        break;
      case "/5":
        println("Button 5 pressed");
        break;
      case "/6":
        println("Button 6 pressed");
        break;
      case "/7":
        println("Button 7 pressed");
        break;
      case "/8":
        println("Button 8 pressed");
        break;
      case "/9":
        println("Button 9 pressed");
        break;
    }
  }
}

void createKeypad() {
   int offsetX = 0; // count out the keys
   int offsetY = 650;
   int nCount = 1;
     for(int col = 0; col < 3; col++) {
        for (int row = 0; row < 3; row++) {
          offsetX += keySpacing;
          //rect(offsetX, offsetY, keySize, keySize);
          String n = Integer.toString(nCount);
          cp5.addButton(n)
            .setPosition(offsetX, offsetY)
            .setValue(100)
            .setSize(keySize, keySize)
            .setColorValue(color(#E8E8E8))
            ;
          // Move to the next
          nCount += 1;
          offsetX += keySize;
        }
        offsetX = 0;
        offsetY += keySize + keySpacing;
     }
     
}
