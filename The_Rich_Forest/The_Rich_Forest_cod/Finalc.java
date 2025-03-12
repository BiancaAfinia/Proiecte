import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class Finalc here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Finalc extends World
{

    /**
     * Constructor for objects of class Finalc.
     * 
     */
    public Finalc()
    {    
        // Create a new world with 600x400 cells with a cell size of 1x1 pixels.
        super(900, 600, 1); 
        addObject(new reset(),400,390);
        addObject(new acasa(),860,540);
    }
}
