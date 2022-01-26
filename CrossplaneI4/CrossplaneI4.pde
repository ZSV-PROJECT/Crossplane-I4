import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioSample hit1, hit2, hit3, hit4;
TickRate rateControl;
FilePlayer filePlayer;
AudioOutput out;


//Engine

//Global Variables
float xCircle, yCircle, dCircle;
color colour1, colour2;
float startTime, endTime, interval, intervalI;
float cylDiff,
  cyl1Int, cyl3Int, cyl2Int, cyl4Int,
  cyl1IntX, cyl3IntX, cyl2IntX, cyl4IntX,
  cyl1IntN, cyl3IntN, cyl2IntN, cyl4IntN,
  cyl1IntO, cyl3IntO, cyl2IntO, cyl4IntO;
boolean engineON, lock;
float x, RATEx;
boolean RATEUP, RATEDOWN;
float speedMod;
int revs;
float revL;
int SS;

boolean cyl1, cyl2, cyl3, cyl4;


void setup()
{
  size(800, 800);
  background(0);
  xCircle = width/2;
  yCircle = height/2.8;
  dCircle = height/10;
  colour1 = color(0, 255, 0);
  colour2 = color(0, 100, 200);
  startTime = millis();
  interval = 1000;
  intervalI = interval;
  engineON = true;
  cyl1 = false;
  fill(colour2);
  circle(xCircle, yCircle, dCircle);
  circle(xCircle, yCircle*1.3, dCircle);
  circle(xCircle, yCircle*1.6, dCircle);
  circle(xCircle, yCircle*1.9, dCircle);
  SS = second() - second();

  x = 0.72;
  speedMod = .04;

  cyl1Int = 1000 + startTime;
  cyl3Int = 999999999;
  cyl2Int = 999999999;
  cyl4Int = 999999999;

  cyl1IntX = 720;
  cyl3IntX = 900;
  cyl2IntX = 990;
  cyl4IntX = 1170;

  cyl1IntN = 990;
  cyl3IntN = 1170;
  cyl2IntN = 1260;
  cyl4IntN = 1440;

  cyl1IntO = 270 / x;
  cyl3IntO = 180 / x;
  cyl2IntO = 90 / x;
  cyl4IntO = 180 / x;

  lock = true;

  revs = 0;
  revL = 720 / x;

  cylDiff = 720 / x;

  minim = new Minim(this);
  hit1 = minim.loadSample("hit1.wav");
  hit3 = minim.loadSample("hit1.wav");
  hit2 = minim.loadSample("hit1.wav");
  hit4 = minim.loadSample("hit1.wav");
  frameRate = 2000;
}

void draw()
{
  background(0);
  cyl1IntO = 270 / x;
  cyl3IntO = 180 / x;
  cyl2IntO = 90 / x;
  cyl4IntO = 180 / x;
  SS = 1;
  cylDiff = 720 / x;

  endTime = millis();
  textSize(24);
  fill(colour2);
  RATEx = (((((x*(1/0.72))*60)*10)/5)/2);
  text (revs, width/8, height/5);
  text ("Rate: "+ int(RATEx), width/8, height/6);

  if (endTime-startTime >= interval)
  {
    interval = ((interval) + (intervalI));
  }
  if (endTime >= cyl1Int)
  {
    cyl1 = true;
    cyl3 = false;
    cyl2 = false;
    cyl4 = false;
    cyl1Int = (cyl1Int + cylDiff);
    cyl3Int = cyl1Int - cyl3IntO*3;
    hit1.trigger();
  }

  if (endTime >= cyl3Int && cyl1)
  {

    cyl1 = false;
    cyl3 = true;
    cyl2 = false;
    cyl4 = false;
    cyl3Int = (cyl3Int + cylDiff);
    cyl2Int = cyl3Int - cyl2IntO*7;
    hit3.trigger();
  }

  if (endTime >= cyl2Int && cyl3)
  {

    cyl1 = false;
    cyl3 = false;
    cyl2 = true;
    cyl4 = false;
    cyl2Int = (cyl2Int + cylDiff);
    cyl4Int = cyl2Int - cyl4IntO*3;
    hit2.trigger();
  }

  if (endTime >= cyl4Int && lock == false)
  {
    revs = (revs + 1);
    cyl1 = false;
    cyl3 = false;
    cyl2 = false;
    cyl4 = true;
    cyl4Int = (cyl4Int + cylDiff);
    hit4.trigger();
  }

  ////////////////////////////////////////////

  if (engineON)
  {
    if (cyl1)
    {
      fill(colour1);
      circle(xCircle, yCircle, dCircle);
      fill(colour2);
      circle(xCircle, yCircle*1.3, dCircle);
      circle(xCircle, yCircle*1.6, dCircle);
      circle(xCircle, yCircle*1.9, dCircle);
      cyl2 = false;
      cyl3 = false;
      cyl4 = false;
    } else if (cyl3)
    {
      fill(colour2);
      circle(xCircle, yCircle, dCircle);
      circle(xCircle, yCircle*1.3, dCircle);
      fill(colour1);
      circle(xCircle, yCircle*1.6, dCircle);
      fill(colour2);
      circle(xCircle, yCircle*1.9, dCircle);
      cyl1 = false;
      cyl2 = false;
      cyl4 = false;
    } else if (cyl2)
    {
      fill(colour2);
      circle(xCircle, yCircle, dCircle);
      fill(colour1);
      circle(xCircle, yCircle*1.3, dCircle);
      fill(colour2);
      circle(xCircle, yCircle*1.6, dCircle);
      circle(xCircle, yCircle*1.9, dCircle);
      cyl1 = false;
      cyl3 = false;
      cyl4 = false;
      lock = false;
    } else if (cyl4)
    {
      fill(colour2);
      circle(xCircle, yCircle, dCircle);
      circle(xCircle, yCircle*1.3, dCircle);
      circle(xCircle, yCircle*1.6, dCircle);
      fill(colour1);
      circle(xCircle, yCircle*1.9, dCircle);
      text (revs, width/8, height/5);
      cyl1 = false;
      cyl3 = false;
      cyl2 = false;
    }
  }

  if (RATEUP)
  {
    x = x + speedMod;
  }

  if (RATEDOWN && x > 0.72)
  {
    x = x - speedMod;
  }
}

void keyPressed()
{
  {
    if (key == 'w' || key == 'W')
    {
      RATEUP = true;
      RATEDOWN = false;
    } else if (key == 's' || key == 'S')
    {
      RATEUP = false;
      RATEDOWN = true;
    }
  }
}

void keyReleased()
{
  {
    if (key == 'w' || key == 'W')
    {
      RATEUP = false;
    } else if (key == 's' || key == 'S')
    {
      RATEDOWN = false;
    }
  }
}
