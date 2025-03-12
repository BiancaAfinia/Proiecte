import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class incep extends Actor
{
    public void act() 
    {
       if(Greenfoot.mouseClicked(this))
         Greenfoot.setWorld(new MyWorld());
    }    
}
