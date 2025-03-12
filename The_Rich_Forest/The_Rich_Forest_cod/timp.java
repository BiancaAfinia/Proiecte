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
    private int r=0;
    private int timer=55*60;
    public void act() 
    {
       timer--;
        if (timer % 55 == 0) updateImage();
        if (timer < 1) 
        {
           Greenfoot.setWorld(new Finalp());
            Greenfoot.stop();
            Greenfoot.playSound("sfarsitsta.wav");
     
    }
        }
    private void updateImage()
    {
        setImage(new GreenfootImage("Timp: " + timer/55,30, Color.WHITE, Color.BLACK));
    }
}
