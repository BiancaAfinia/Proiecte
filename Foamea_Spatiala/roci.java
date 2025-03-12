import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class roci here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class roci extends Actor
{
    /**
     * Act - do whatever the roci wants to do. This method is called whenever
     * the 'Act' or 'Run' button gets pressed in the environment.
     */
    
public void sfarsit()
{  Greenfoot.setWorld(new Final());
}
    public void catchracheta()
    {if(isTouching(racheta.class))
        removeTouching(racheta.class);
     }
    public void act() 
    {int rac=1; move(-3);
        if(getX()==0)setLocation(950,Greenfoot.getRandomNumber(540));
        if(isTouching(racheta.class))
        rac--;
        if(rac==0)
        {sfarsit();
            Greenfoot.playSound("sfarsit.wav");
    // Greenfoot.stop();
        }
        catchracheta();
         }
     

}