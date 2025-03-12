import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)
public class car extends Actor
{
    public void act() 
    { int r=1;
          if(Greenfoot.isKeyDown("left"))
    {        setLocation(getX()-5,getY());
 
    }
if(Greenfoot.isKeyDown("right"))
    {setLocation(getX()+5,getY());
    }
    if(Greenfoot.isKeyDown("up"))
    {setLocation(getX(),getY()-5);
    }
    if(Greenfoot.isKeyDown("down"))
    {setLocation(getX(),getY()+5);
    } 
    }    
}
