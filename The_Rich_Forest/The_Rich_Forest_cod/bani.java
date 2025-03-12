import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class bani extends Actor
{int score=0;
    public void act() 
    {setRotation(270);
       move(-3);
       getWorld().showText(" " + score, 880, 20 );
       if(isTouching(car.class))
         {setLocation(1000,Greenfoot.getRandomNumber(900));
             score+=10;}
       if(isAtEdge())setLocation(1000,Greenfoot.getRandomNumber(900));
       if(isTouching(copac.class))
       setLocation(Greenfoot.getRandomNumber(900),10);
        if(isTouching(pom.class))
       setLocation(Greenfoot.getRandomNumber(900),10);
        if(isTouching(butoi.class))
       setLocation(Greenfoot.getRandomNumber(900),10);
  if(isTouching(bani.class))
       setLocation(Greenfoot.getRandomNumber(900),10);
    }    
}
