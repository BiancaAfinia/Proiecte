import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class Pagprin0 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Pagprin0 extends World
{

    /**
     * Constructor for objects of class Pagprin0.
     * 
     */
    public Pagprin0()
    {    
        // Create a new world with 600x400 cells with a cell size of 1x1 pixels.
        super(980, 540, 1); 

        prepare();
    }

    /**
     * Prepare the world for the start of the program.
     * That is: create the initial objects and add them to the world.
     */
    public void act()
    {if(Greenfoot.isKeyDown("enter"))
            Greenfoot.setWorld(new pagprin1());
    }

    /**
     * Prepare the world for the start of the program.
     * That is: create the initial objects and add them to the world.
     */
    private void prepare()
    {
    }
}
