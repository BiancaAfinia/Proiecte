import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class racheta here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class racheta extends Actor
{
   int score = 0;
    /**
     * Act - do whatever the racheta wants to do. This method is called whenever
     * the 'Act' or 'Run' button gets pressed in the environment.
     */
    
    public void act() 
    {int ok=0;
        
        if(Greenfoot.isKeyDown("left"))
    {        setLocation(getX()-4,getY());
 
    }
if(Greenfoot.isKeyDown("right"))
    {setLocation(getX()+4,getY());
    }
    if(Greenfoot.isKeyDown("up"))
    {setLocation(getX(),getY()-4);
    }
    if(Greenfoot.isKeyDown("down"))
    {setLocation(getX(),getY()+4);
    }  }  
}
