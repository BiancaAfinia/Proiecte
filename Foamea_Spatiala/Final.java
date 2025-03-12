import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class Final here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Final extends World
{

    /**
     * Constructor for objects of class Final.
     * 
     */
    public Final()
    {    
        // Create a new world with 600x400 cells with a cell size of 1x1 pixels.
        super(980, 540, 1);
        addObject(new Back(),50,500);
        addObject(new Reset(),500,300);
   prepare();
    }
    
    private void prepare()
    {emoji emoji = new emoji();
        addObject(emoji,169,58);
        emoji emoji2 = new emoji();
        addObject(emoji2,728,59);
        emoji emoji3 = new emoji();
        addObject(emoji3,728,60);
    }
}
