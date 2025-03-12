import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class MyWorld here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class MyWorld extends World
{

    /**
     * Constructor for objects of class MyWorld.
     * 
     */
   
    public MyWorld()
    {      super(980, 540, 1);
        addObject(new timp(),400,20);
        addObject(new racheta(),156,100);
        addObject(new roci(),1000,50);
        addObject(new roci(),1000,200);
        addObject(new roci(),800,450);
        addObject(new roci(),800,250);
        addObject(new roci(),1000,700);
        addObject(new eat(),1000,350);
        
        
    }
}
