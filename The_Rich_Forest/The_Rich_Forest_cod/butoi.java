import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class butoi extends Actor
{
    public void act() 
    { int r=1;
        setRotation(270);
       move(-3);
        if(isAtEdge())
        {setLocation(Greenfoot.getRandomNumber(900),0);}
       if(isTouching(car.class))
        r--;
        if(r==0)
        {//Greenfoot.stopSound();
            Greenfoot.setWorld(new Finalc());
            Greenfoot.playSound("sfarsit.wav");
     //Greenfoot.stop();
        }
     
        if(isTouching(copac.class))
       setLocation(Greenfoot.getRandomNumber(900),0);
        if(isTouching(pom.class))
       setLocation(Greenfoot.getRandomNumber(900),0);
        if(isTouching(butoi.class))
       setLocation(Greenfoot.getRandomNumber(900),0);
      
        
    }    
}
