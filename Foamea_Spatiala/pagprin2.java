import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class pagprin2 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class pagprin2 extends World
{

    /**
     * Constructor for objects of class pagprin2.
     * 
     */
    public pagprin2()
    {    
        // Create a new world with 600x400 cells with a cell size of 1x1 pixels.
        super(980, 550, 1); 
       
    }

    /**
     * Prepare the world for the start of the program.
     * That is: create the initial objects and add them to the world.
     */
    public void act()
    {Greenfoot.delay(15);
        if(Greenfoot.isKeyDown("enter"))
        Greenfoot.setWorld(new MyWorld());
        
    }
}
