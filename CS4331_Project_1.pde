import controlP5.*;
import java.util.Timer;
import java.util.TimerTask;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

ControlP5 cp5;

int margin = 5;
int centerX = 500;
int centerY = 750;

LocalDateTime dateRaw = LocalDateTime.now();
DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("HH:mm");
String date = dateRaw.format(formatDate);

boolean highTemp = false;
boolean timerActive = false;

int keySize = 95; // Diameter of key
int keyCenter = keySize / 2;
int keySpacing = 10;

DropdownList ddl; // For extras
String[] options = {"Normal","Defrost", "Popcorn"};

Timer timer = new Timer();
MyTimerTask timert = new MyTimerTask();
int timerValue = 0; // The int value of timerString
String timerString = ""; // Convert it to a string for display purposes, append to this then convert to int
Textlabel t;
Textlabel wattage;

// The microwave timer
class MyTimerTask extends TimerTask {

  public MyTimerTask() {
  }

  @Override
    public void run() {
    if (timerValue > 0) {
      timerString = String.format("%02d:%02d", timerValue / 60, timerValue % 60);
      println(timerString);
      timerValue--;
    } else {
    }
  }
}


void setup() { // Draw the background UI
  cp5 = new ControlP5(this);
  size(516, 750);

  timer.scheduleAtFixedRate(timert, 0, 1000);

  /*
  CREATE THE CP5 ELEMENTS BELOW 
  */
  t = new Textlabel(cp5, timerString, 100, 100);
  t.setFont(createFont("Arial", 48));

  createKeypad(); // Create the keypad

  ddl = cp5.addDropdownList("Cook Options")
          .setPosition(keySize + keySpacing, 250)
          .setSize(keySpacing + keySize * 3 + margin * 2, 500)
          ;

  populateOptions(ddl);

  // Temperature
  cp5.addToggle("highTemp")
     .setLabel("Power")
     .setPosition(keySpacing *4 + keySize *4, 10)
     .setSize(keySize - keySpacing, keySize/3)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(#6c757d)
     .setColorActive(#adb5bd)
     .setValue(false)
     ;
  wattage = cp5.addTextlabel("wattage")
            .setText("High")
            .setPosition(keySize * 5, 40)
            .setFont(createFont("Arial", 16))
            ;
}

void draw() {
  // Fill the background
  background(#212529);
  fill(0);
  rect(keySize + keySpacing, 85, keySize * 3 + keySpacing * 2, 80);
  // Check if timerActive == true
  if (timerActive) {
    // Display the active timer
    t.setValue(timerString);
  } else {
    // Display the time.
    t.setValue(date.toString());
  }
  t.draw(this);
  t.setPosition(200, 100);

  if (highTemp == true) {
    wattage.setText("Low");
  } else {
    wattage.setText("High");
  }
}

// Control the functions of the keys
void controlEvent(CallbackEvent event) {
  if (event.getAction() == ControlP5.ACTION_CLICK) {
    switch(event.getController().getAddress()) {
    case "/1":
      timerActive = true;
      println("Button 1 pressed");
      timerString += "1";
      break;
    case "/2":
      timerActive = true;
      println("Button 2 pressed");
      timerString += "2";
      break;
    case "/3":
      timerActive = true;
      println("Button 3 pressed");
      timerString += "3";
      break;
    case "/4":
      timerActive = true;
      println("Button 4 pressed");
      timerString += "4";
      break;
    case "/5":
      timerActive = true;
      println("Button 5 pressed");
      timerString += "5";
      break;
    case "/6":
      timerActive = true;
      println("Button 6 pressed");
      timerString += "6";
      break;
    case "/7":
      timerActive = true;
      println("Button 7 pressed");
      timerString += "7";
      break;
    case "/8":
      timerActive = true;
      println("Button 8 pressed");
      timerString += "8";
      break;
    case "/9":
      timerActive = true;
      println("Button 9 pressed");
      timerString += "9";
      break;
    case "/0":
      timerActive = true;
      println("Button 0 pressed");
      timerString += "0";
      break;
    case "/Start":
      timerActive = true;
      println("Start pressed");
      if (timerString.length() == 0) {
        timerString = "+00:30";
        timerValue += 30;
        return;
      } else if (timerValue != 0) {
        timerValue += 30;
      } else {
        timerValue = Integer.parseInt(timerString);
      }

      break;
    case "/Stop":
      println("Stop pressed");
      if(timerValue != 0) {
        print("Cancelled at " + timerString); 
        timerString = "";
        timerValue = 0;
        timerActive = false;
      }
      break;
    }
  }
}

// The control event for the cook options
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    String optionName = theEvent.getName();
    int choice = Math.round(theEvent.getController().getValue());
    if(optionName == "Cook Options") {
      switch(choice) {
        case 0:
          timerActive = false;
          println("Normal");
          timerString = "";
          timerValue = 0;
          break;
        case 1:
          println("Defrost chosen");
          timerActive = true;
          timerString = "";
          timerValue = 600;
          break;
        case 2:
          timerActive = true;
          println("Popcorn chosen");
          timerValue = 120;
      }
      timerValue = Integer.parseInt(timerString);
    }
  }
}

void populateOptions(DropdownList ddl) {
  ddl.setBackgroundColor(#6c757d);
  ddl.setColorBackground(#6c757d);
  ddl.setItemHeight(50);
  ddl.setBarHeight(50);
  ddl.setHeight(500);
  ddl.close();
  for (int i=0; i < options.length; i++) {
    ddl.addItem(options[i], i);
  }
}

void createKeypad() {
  int offsetX = keySize; // count out the keys
  int offsetY = 325;
  int nCount = 1;
  for (int col = 0; col < 3; col++) {
    for (int row = 0; row < 3; row++) {
      offsetX += keySpacing;
      //rect(offsetX, offsetY, keySize, keySize);
      String n = Integer.toString(nCount);

      cp5.addButton(n)
        .setPosition(offsetX, offsetY)
        .setValue(100)
        .setSize(keySize, keySize)
        .setColorValue(color(#6c757d))
        .setColorActive(color(155))
        .setColorLabel(#f8f9fa)
        .setColorForeground(color(155))
        .setColorBackground(color(#6c757d))
        ;

      // Move to the next
      nCount += 1;
      offsetX += keySize;
    }
    offsetX = keySize;
    offsetY += keySize + keySpacing;
  }
  offsetX += keySpacing;
  // Create the bottom row of keys next (special cases)
  cp5.addButton("0")
    .setColorValue(color(#6c757d))
    .setColorActive(color(155))
    .setColorForeground(color(155))
    .setColorBackground(color(#6c757d))
    .setPosition(offsetX * 2, offsetY)
    .setSize(keySize, keySize)
    ;
  cp5.addButton("Stop")
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorLabel(#6c757d)
    .setColorForeground(color(155))
    .setColorBackground(color(#FFA7AF))
    .setPosition(offsetX - keyCenter * 2, offsetY)
    .setSize(keySize + keyCenter * 2, keySize)
    ;
  cp5.addButton("Start")
    .setLabel("Start/+30s")
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorLabel(#6c757d)
    .setColorForeground(color(155))
    .setColorBackground(color(#ABFFA7))
    .setPosition(offsetX * 3, offsetY)
    .setSize(keySize + keyCenter * 2, keySize)
    ;
}
