private SpaceShip Traveler;
double sAccel = 0;
public void setup() 
{
  size(500, 500);
  imageMode(CENTER);
  Traveler = new SpaceShip();
}
public void draw() 
{
  background(0, 25, 35);
  Traveler.show();
  Traveler.move();
  Traveler.accelerate();
}
private class SpaceShip extends Floater  
{   
  private PImage ship;
  private double sRadians;
  public SpaceShip()
  {
    myCenterX = width/2;
    myCenterY = height/2;
    myDirectionX = 0;
    myDirectionY = 0;
    ship = loadImage("Sprites/Ship.png");
    sRadians = 0;
  }
  public void show()
  {
    if(dist(mouseX, mouseY, (float)(myCenterX), (float)(myCenterY))!=0)
    {
      sRadians = Math.acos(((float)(myCenterX - mouseX)/dist(mouseX, mouseY, (float)(myCenterX), (float)(myCenterY))));
    }
    if((myCenterY - mouseY)<0)
    {
      sRadians *= -1;
    }
    pushMatrix();
    translate((float)myCenterX, (float)myCenterY);
    rotate((float)sRadians - radians(90));
    image(ship, 0, -4);
    popMatrix();
  }
  public void accelerate()   
  {          
    //convert the current direction the floater is pointing to radians        
    //change coordinates of direction of travel
      myDirectionX = -((sAccel) * Math.cos(sRadians));   
      myDirectionY = -((sAccel) * Math.sin(sRadians));
  }
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
  // abstract public void setX(int x);  
  // abstract public int getX();   
  // abstract public void setY(int y);   
  // abstract public int getY();   
  // abstract public void setDirectionX(double x);   
  // abstract public double getDirectionX();   
  // abstract public void setDirectionY(double y);   
  // abstract public double getDirectionY();   
  // abstract public void setPointDirection(int degrees);   
  // abstract public double getPointDirection(); 

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
    sAccel = 4;
  }
}
void keyReleased()
{
  if(key == 'w')
  {
    sAccel = 0;
  }
}
