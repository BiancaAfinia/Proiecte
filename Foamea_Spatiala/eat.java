import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class eat here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class eat extends Actor
{int score=0;
    /**
     * Act - do whatever the eat wants to do. This method is called whenever
     * the 'Act' or 'Run' button gets pressed in the environment.
     */
    public void act() 
    {
       move(-2);
       getWorld().showText("Scor: " + score, 520, 20 );
       if(isTouching(racheta.class))
         {setLocation(1000,Greenfoot.getRandomNumber(540));
             score+=10;}
       if(getX()==0)setLocation(1000,Greenfoot.getRandomNumber(540));

    }    
}
