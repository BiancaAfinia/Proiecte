import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class Finalp here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Finalp extends World
{

    /**
     * Constructor for objects of class Finalp.
     * 
     */
    public Finalp()
    {    
        // Create a new world with 600x400 cells with a cell size of 1x1 pixels.
        super(901, 601, 1); 
        addObject(new reset(),400,400);
        addObject(new acasa(),850,530);
    }
}
