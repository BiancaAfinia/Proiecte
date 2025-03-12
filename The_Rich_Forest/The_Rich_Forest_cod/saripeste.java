import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class saripeste extends Actor
{
    public void act() 
    {
        getWorld().showText("SARI PESTE", 780, 500 );
        if(Greenfoot.mouseClicked(this))
         Greenfoot.setWorld(new Pag3());
    }    
}
