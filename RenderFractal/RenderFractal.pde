void setup(){
   size(1280, 720);
   colorMode(HSB, 1);
}

void draw(){
  noLoop();
  background(255);
  //Componentes de la constnante C
  //Parte real
  float ca = random(-1, 1);
  //Parte imaginaria
  float cb = random(-1, 1);
  
  float w = 4;
  float h = (w * height) / width;
  
  float xmin = -w / 2;
  float ymin = -h / 2;
  
  loadPixels();
  
  int maxiterations = 100;
  
   float xmax = xmin + w;
   float ymax = ymin + h;
   
   float dx = (xmax - xmin) / (width);
   float dy = (ymax - ymin) / (height);
  
    float y = ymin;
    for(int i = 0; i < height; i++){
      float x = xmin;
      
      for(int j = 0; j < width; j++){
        float a = x; 
        float b = y;
        int n = 0;
        while(n < maxiterations){
          float aa = a * a;
          float bb = b * b;
          float twoab = 2.0 * a * b;
          a = aa - bb + ca;
          b = twoab + cb;
          
          if(aa + bb > 20.0){
            break;
          }
          n++;
        }
        if(n == maxiterations){
          pixels[j + i * width] = color(0);
        }
        else{
          float hue = sqrt(float(n) / maxiterations);
          pixels[j + i * width] = color(hue, 255, 255);
        }
        x += dx;
    }
    y += dy;
  }
  updatePixels();
  save("fractal.jpg");
  //println(frameRate);
  //println(ca);
  //println(cb);
  valuesFiles(ca, cb);
  exit();
}

void valuesFiles(float real, float imaginario){
  PrintWriter wr;
  wr = createWriter("values.txt");
  
  if(real > 0 && imaginario > 0){
    wr.println("c = " + real + " + " + imaginario + "i");
  }
  else if(real > 0 && imaginario < 0){
    wr.println("c = " + real + " " + imaginario + "i");
  }
  else if(real < 0 && imaginario > 0){
    wr.println("c = " + real + " + " + imaginario + "i");
  }
  else if(real < 0 && imaginario < 0){
    wr.println("c = " + real + " " + imaginario + "i");
  }
  
  wr.flush();
  wr.close();
}
