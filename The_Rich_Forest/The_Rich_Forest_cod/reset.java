import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)
public class reset extends Actor
{
    public void act() 
    {
        if(Greenfoot.mouseClicked(this))
         Greenfoot.setWorld(new MyWorld());
    }    
}
