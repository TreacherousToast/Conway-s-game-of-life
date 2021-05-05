boolean[][] isAlive = new boolean[300][300]; // [x][y]
boolean[][] updatedLives = new boolean[300][300];
int xViewOffset = 50;
int yViewOffset = 50;
int updatePeriod = 1; // update period in milliseconds
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
      fill(isAlive[j+xViewOffset][i+yViewOffset] ? 0 : 255);
      rect(j*10,i*10,10,10);
    }
  }
  if (update) update();
}
void update()
{
  delay(updatePeriod);
  for (int i = 1; i < isAlive[0].length-1; i++) // y
  {
    for (int j = 1; j < isAlive.length-1; j++) // x
    {
      int neighbours = 0; // count neighbours
      for (int a = -1; a < 2; a++)
        for (int b = -1; b < 2; b++)
          if (isAlive[j+b][i+a] == true)
            neighbours++;
            
      if (isAlive[j][i]) // logic for the cellular automata
        neighbours--;
      if (neighbours == 2 && isAlive[j][i] || neighbours == 3 && isAlive[j][i])
        updatedLives[j][i] = true;
      else if (neighbours < 2 && isAlive[j][i] || neighbours > 3 && isAlive[j][i])
        updatedLives[j][i] = false;
      else if (neighbours == 3 && isAlive[j][i])
        updatedLives[j][i] = true;
    }
  }
  // update main array
  for (int i = 1; i < isAlive[0].length-1; i++) // y
    for (int j = 1; j < isAlive.length-1; j++) // x
      isAlive[j][i] = updatedLives[j][i];
}
void mouseClicked()
{
  isAlive[floor(mouseX/10)+xViewOffset][floor(mouseY/10)+yViewOffset] = !isAlive[floor(mouseX/10)+xViewOffset][floor(mouseY/10)+yViewOffset];
}
void keyPressed()
{
  if (keyCode == ENTER || keyCode == RETURN)
    update = !update;
  else if (key == ' ')
    update();
  else if (keyCode == UP && yViewOffset > 2)
    yViewOffset--;
  else if (keyCode == DOWN && yViewOffset < isAlive[0].length-2)
    yViewOffset++;
  else if (keyCode == LEFT && xViewOffset > 2)
    xViewOffset--;
  else if (keyCode == RIGHT && yViewOffset < isAlive.length-2)
    xViewOffset++;
}
