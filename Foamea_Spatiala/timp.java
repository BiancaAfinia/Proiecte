import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

/**
 * Write a description of class timp here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class timp extends Actor
{
    /**
     * Act - do whatever the timp wants to do. This method is called whenever
     * the 'Act' or 'Run' button gets pressed in the environment.
     */
    private int timer = 55*60;

    public timp()
    {
        updateImage();
    }

    public void act()
    {
        timer--;
        
        if (timer % 55 == 0) updateImage();
        if (timer < 1) 
        {
            aicastigat();
            //Greenfoot.stop();
            Greenfoot.playSound("sfarsitsta.wav");
     
            
        }
    }

    private void updateImage()
    {
        setImage(new GreenfootImage("Timp: " + timer/55, 40, Color.WHITE, Color.BLACK));
    }
    public void aicastigat()
    {
           Greenfoot.setWorld(new Felicitari());
    }
}