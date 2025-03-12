import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class Felicitari here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Felicitari extends World
{

    /**
     * Constructor for objects of class Felicitari.
     * 
     */
    public Felicitari()
    {    
        // Create a new world with 600x400 cells with a cell size of 1x1 pixels.
        super(980, 540, 1); 
        addObject(new Back(),50,500);
        addObject(new Reset(),500,300);
        prepare();
   
    }
 
    private void prepare()
    {emoji emoji = new emoji();
        addObject(emoji,240,65);
        emoji emoji2 = new emoji();
        addObject(emoji2,617,67);
    }
}
