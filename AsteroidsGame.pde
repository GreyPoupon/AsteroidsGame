private SpaceShip Traveler;
private ArrayList <Asteroid> Rock;
private ArrayList <Missile> Ammo;

public void setup() 
{
  size(800, 800);
  imageMode(CENTER);
  rectMode(CENTER);
  Traveler = new SpaceShip();
  Rock = new ArrayList <Asteroid>();
  Ammo = new ArrayList <Missile>();
  for(int r = 0; r < 11; r++) {Rock.add(new Asteroid());}
}

public void draw() 
{
  background(0, 25, 35);
  Traveler.direction();
  Traveler.show();
  Traveler.move();
  Traveler.accelerate();
  for(int i = 0; i < Rock.size(); i++)
  {
    Rock.get(i).show();
    Rock.get(i).move();
    for(int e = 0; e < Ammo.size(); e++)
    {
      if(dist(Rock.get(i).getX(), Rock.get(i).getY(), Ammo.get(e).getX(), Ammo.get(e).getY()) <= 30)
      {
        Rock.remove(i);
        Ammo.remove(e);
        break;
      }
    }
  }
  for(int a = 0; a < Ammo.size(); a++)
  {
    Ammo.get(a).show();
    Ammo.get(a).move();
    Ammo.get(a).accelerate();
    if(Ammo.get(a).getX() < 0 || Ammo.get(a).getX() > width || Ammo.get(a).getY() < 0 || Ammo.get(a).getX() > height)
    {
      Ammo.remove(a);
    }
  }
}

private class Missile extends Floater
{
  private PImage bomb;
  public Missile()
  {
    myCenterX = 0;
    myCenterY = 0;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    bomb = loadImage("Sprites/Missile.png");
  }
  public void show()
  {
    pushMatrix();
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)myPointDirection - radians(90));
    image(bomb, 0, 0);
    popMatrix();
  }
  public void accelerate()   
  {     
    myDirectionX = -(20 * Math.cos(myPointDirection));   
    myDirectionY = -(20 * Math.sin(myPointDirection));
  }
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY; 
  }   
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)(myCenterX);}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)(myCenterY);}
  public void setDirectionX(double x) {myDirectionX = x;}  
  public double getDirectionX() {return myDirectionX;} 
  public void setDirectionY(double y) {myDirectionY = y;} 
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(double degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

private class SpaceShip extends Floater  
{   
  private PImage ship;
  private double sAccel;
  public SpaceShip()
  {
    myCenterX = width/2;
    myCenterY = height/2;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    ship = loadImage("Sprites/Ship.png");
    sAccel = 0;
  }
  public void direction()
  {
    if(dist(mouseX, mouseY, (float)(myCenterX), (float)(myCenterY))!=0)
    {
      myPointDirection = Math.acos(((float)(myCenterX - mouseX)/dist(mouseX, mouseY, (float)(myCenterX), (float)(myCenterY))));
    }
    if((myCenterY - mouseY) < 0)
    {
      myPointDirection *= -1;
    }
  }
  public void show()
  {
    pushMatrix();
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)myPointDirection - radians(90));
    image(ship, 0, -4);
    popMatrix();
  }
  public void accelerate()   
  {          
    //convert the current direction the floater is pointing to radians        
    //change coordinates of direction of travel
      myDirectionX += -((sAccel) * Math.cos(myPointDirection));   
      myDirectionY += -((sAccel) * Math.sin(myPointDirection));
  }
  public void hyperdrive()
  {
    float xDrive = (float)myCenterX;
    float yDrive = (float)myCenterY;
    myCenterX = mouseX;
    myCenterY = mouseY;
    fill(150, 0 ,200);
    ellipse(xDrive, yDrive, 50, 50);
    ellipse(mouseX, mouseY, 50, 50);
  }
  public void setAccel(double a) {sAccel = a;}
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)(myCenterX);}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)(myCenterY);}
  public void setDirectionX(double x) {myDirectionX = x;}  
  public double getDirectionX() {return myDirectionX;} 
  public void setDirectionY(double y) {myDirectionY = y;} 
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(double degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

private class Asteroid extends Floater
{
  protected PImage meteor;
  protected float rotationRate;
  public Asteroid()
  {
    myCenterX = 0;
    myCenterY = 0;
    myDirectionX = (Math.random()*10)-5;
    myDirectionY = (Math.random()*10)-5;
    meteor = loadImage("Sprites/Meteor.png");
    rotationRate = (float)(Math.random()*10)-5;
  }
  public void show()
  {
    myPointDirection += radians(rotationRate);
    pushMatrix();
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)myPointDirection - radians(90));
    image(meteor, 0, -4);
    popMatrix();
  }
  public void move ()   //move the floater in the current direction of travel
  {            
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;        
    if(myCenterX > width + 32)
    {     
      myCenterX = -32;    
    }    
    else if (myCenterX < -32)
    {     
      myCenterX = width + 32;    
    }    
    if(myCenterY >height + 32)
    {    
      myCenterY = -32;    
    }   
    else if (myCenterY < -32)
    {     
      myCenterY = height + 32;    
    }   
  }   
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)(myCenterX);}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)(myCenterY);}
  public void setDirectionX(double x) {myDirectionX = x;}  
  public double getDirectionX() {return myDirectionX;} 
  public void setDirectionY(double y) {myDirectionY = y;} 
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(double degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

private class SplitAsteroid extends Asteroid
{
  public SplitAsteroid() {meteor = loadImage("Sprites/SplitMeteor.png");}
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(double degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotateObject (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

void keyPressed()
{
  if(key == 'w')
  {
    Traveler.setAccel(0.15);
  }
  if(key == 's')
  {
    Traveler.setDirectionX(0);
    Traveler.setDirectionY(0);
  }
  if(key == 'q')
  {
    Traveler.hyperdrive();
  }
}

void keyReleased()
{
  if(key == 'w')
  {
    Traveler.setAccel(0);
  }
}

void mousePressed()
{
  Ammo.add(new Missile());
  Ammo.get(Ammo.size()-1).setPointDirection(Traveler.getPointDirection());
  Ammo.get(Ammo.size()-1).setX(Traveler.getX() - (int)(26* Math.cos(Traveler.getPointDirection())));
  Ammo.get(Ammo.size()-1).setY(Traveler.getY() - (int)(26* Math.sin(Traveler.getPointDirection())));
}