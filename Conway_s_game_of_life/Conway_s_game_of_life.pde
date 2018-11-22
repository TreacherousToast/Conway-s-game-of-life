boolean[][] isAlive = new boolean[300][300]; // [x][y]
boolean[][] updatedLives = new boolean[300][300];
int xViewBuffer = 50;
int yViewBuffer = 50;
boolean update = false;

void setup()
{
  size(640,360);
}
void draw()
{
  background(200);
  for (int i = 0; i < height/10; i++)
  {
    for (int j = 0; j < width/10; j++)
    {
      if (isAlive[j+xViewBuffer][i+yViewBuffer] == true)
      {
        fill(0);
      }
      else
      {
        fill(255);
      }
      rect(j*10,i*10,10,10);
    }
  }
  if (update == true)
  {
    update();
  }
}
void update()
{
  delay(1); // change this to change frequency of updates
  for (int i = 1; i < isAlive[0].length-1; i++) // y
  {
    for (int j = 1; j < isAlive.length-1; j++) // x
    {
      int neighbors = 0;
      for (int a = -1; a < 2; a++)
      {
        for (int b = -1; b < 2; b++)
        {
          if (isAlive[j+b][i+a] == true)
          {
            neighbors++;
          }
        }
      }
      if (isAlive[j][i] == true)
      {
        neighbors--;
      }
      if (neighbors == 2 && isAlive[j][i] == true || neighbors == 3 && isAlive[j][i] == true)
      {
        updatedLives[j][i] = true;
      }
      else if (neighbors < 2 && isAlive[j][i] == true || neighbors > 3 && isAlive[j][i] == true)
      {
        updatedLives[j][i] = false;
      }
      else if (neighbors == 3 && isAlive[j][i] == false)
      {
        updatedLives[j][i] = true;
      }
    }
  }
  for (int i = 1; i < isAlive[0].length-1; i++) // y
  {
    for (int j = 1; j < isAlive.length-1; j++) // x
    {
      isAlive[j][i] = updatedLives[j][i];
    }
  }
}
void mouseClicked()
{
  if (isAlive[floor(mouseX/10)+xViewBuffer][floor(mouseY/10)+yViewBuffer] == true)
  {
    isAlive[floor(mouseX/10)+xViewBuffer][floor(mouseY/10)+yViewBuffer] = false;
  }
  else
  {
    isAlive[floor(mouseX/10)+xViewBuffer][floor(mouseY/10)+yViewBuffer] = true;
  }
}
void keyPressed()
{
  if (update == false)
  {
    update = true;
  }
  else
  {
    update = false;
  }
}
