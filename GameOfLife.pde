//Author: Shasindran Poonudurai
/*This is my version of game of life
The rules for John Conway's Game of Life are:

For a space that is 'populated':

Each cell with one or no neighbors dies, as if by loneliness.
Each cell with four or more neighbors dies, as if by overpopulation.
Each cell with two or three neighbors survives.

For a space that is 'empty' or 'unpopulated':

Each cell with three neighbors becomes populated.

Source: http://www.bitstorm.org/gameoflife/

When the program start the the grids are empty. You can either draw your cells with the 
mouse or randomly generate cells by pressing the key r. Click the mouse to activate a cell.

Once you draw or randomly generate cells, press the space bar to start/run the game. 
Press the space bar again to toggle the run mode.

Press 'c' to clear the cells and draw or generate random cells.

During the pause mode or the run mode, you can draw a cell by clicking on the grid.

*/

//Variables
int SizeOfCells = 8;
int state;

int num_row = 600/SizeOfCells;          //600x600 grid cells
int num_column = 600/SizeOfCells;

//int mid_width = 600/SizeOfCells/2;
//int mid_height = 600/SizeOfCells/2;


//block colors for dead/alive cells
color alive = color(200,255,0);
color dead = color(0);

//Array of cells
int[][] cells;
int[][] copycells;       // for saving the the cells new state during the iteration

boolean OnPause = true;

void setup(){
  size (600,720);                        //600x600 grid plus additional space to indicate the game mode, paused or running      
  
  
  // Instantiate arrays
  cells = new int[num_row][num_row];
  copycells = new int[num_column][num_row];
  
  //draw te grid
  stroke(48);
  
  noSmooth();
  background(255);
  
  //Interval time
  frameRate(10);
  
} 

void draw(){
  
  //Draw cells
  for (int x=0; x<num_column; x++) {
    for (int y=0; y<num_row; y++) {
      if (cells[x][y]==1) {
        fill(alive); // If alive
      }
      else {
        fill(dead); // If dead
      }
      rect (x*SizeOfCells, y*SizeOfCells, SizeOfCells, SizeOfCells);
    }
  }
  
  updatetext();

  //draw your own cells
  manualCells(OnPause);
  
  //start the game with space bar
  runGame(OnPause);
}


void keyPressed() {
  if (key=='r' || key == 'R') {
    // Restart: reinitialization of cells
     randomcells(0);
  }
  
   if (key=='q' || key == 'Q') {
    // Restart: reinitialization of cells
     randomcells(1);
  }
  
   if (key== 'w'|| key == 'W') {
    // Restart: reinitialization of cells
     randomcells(2);
  }
  
   if (key=='e'|| key == 'E') {
    // Restart: reinitialization of cells
     randomcells(3);
  }
  if (key==' ' || key == ' ') { // On/off of pause
    OnPause = !OnPause; 
    runGame(OnPause);
  }
  if (key=='c' || key == 'C') { // Clear all
    for (int x=0; x<num_column; x++) {
      for (int y=0; y<num_row; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
    OnPause=true;
  }
} 

//functions that draws random cells when the key q,w,e,r is pressed
void randomcells(int rand){
  
  //clear the grids before generate random cells
  for (int x=0; x<num_column; x++) {
      for (int y=0; y<num_row; y++) {
        cells[x][y] = 0; // Save all to zero
      }
  }
  
  
  switch(rand){   
                //generate random cells 
      case 0:
            for (int x=0; x<num_column; x++) {
                for (int y=0; y<num_row; y++) {
                  if (random(0,10) < 3) {                          //Probablity of alive at the beginning
                      state = 1;
                  }
                  else {
                      state = 0;
                  }
                    cells[x][y] = state; // Save state of each cell
                }
            }
        break;  
        
      case 1:
            int x = int (random(5,70));             // 600/8 = 75 cells //change the values here if the size of cell is changed
            int y = int (random(5,70));
            
            //generate a line of 10 cells
            for (int j = x-5; j < x+5; j++) {
               cells[j][y] = 1;                    // Save state of each cell
            }
       break;
        
       case 2:
            int j = int (random(5,70));
            int i = int (random(5,70));
             
             //generate glider cells
               cells[i][j] = 1; 
               cells[i+1][j] = 1;
               cells[i+2][j] = 1;
               cells[i+2][j-1] = 1;
               cells[i+1][j-2] = 1;
       
        break; 
        
       case 3:
               int k = int (random(5,70));
               int l = int (random(5,70));
             //generate small exploder cells
               cells[k][l] = 1; 
               cells[k+1][l] = 1;
               cells[k+2][l] = 1;
               cells[k][l+1] = 1;
               cells[k+2][l+1] = 1;
               cells[k+1][l+2] = 1;
               cells[k+1][l-1] = 1;
        break;    
      }
}
  

//function that runs the game when the game is not on the pause mode
void runGame(boolean pause){
  
  if(!pause){
   //backup the cells
   for (int y=0; y<num_column; y++) {
      for (int x=0; x<num_row; x++) {
        copycells[x][y]=cells[x][y];
      }  
    }
    
      //click the mouse to manually kill or create cell during the run
      if(mousePressed){
        int mouse_x = int(map(mouseX, 0, width, 0, width/SizeOfCells));
        mouse_x = constrain(mouse_x, 0, width/SizeOfCells-1);
        int mouse_y = int(map(mouseY, 0, height, 0, height/SizeOfCells));
        mouse_y = constrain(mouse_y, 0, height/SizeOfCells-16);              //why - 16? The reason is that I need some space to indicate the game mode, run mode or pause mode. 
                                                                             //Therefore, I draw additional space (h=+120) -> 120/(SizeOfCells) = 15. 
                                                                             //To make sure the mouse is not out of boundry,we put -16. 
  
        // Check against cells in 
        if (copycells[mouse_x][mouse_y]==1) {   //kill the cell is alive
          cells[mouse_x][mouse_y]=0; 
          fill(dead); 
        }
        else { 
          cells[mouse_x][mouse_y]=1;           // Make alive
          fill(alive); 
        }
      } 
      
    //run through each cells and check it's surrounding neighbours
    for (int y=0; y<num_column; y++) {
      for (int x=0; x<num_row; x++) {
        int num = CountNeighbours(x,y);
        
        //rules are applied here
        if(copycells[x][y] == 1 && num !=2 && num !=3){        //each cells with below than 2 and more than 3 neighbours dies
                                                            
            fill(dead);
            cells[x][y]=0;
            
         
        }
        else if(copycells[x][y] == 0 && num ==3){              //new cells born if it has 3 neighbours alive
            fill(alive);
            cells[x][y]=1;
            
        }    
      }  
    }  
  }
}

//function that counts the neighbour of each cells
int CountNeighbours(int row, int column){
                                                            
  int num_neighbours =0;
  
  //the following steps are to check the neighbours
  
  //corner blocks have only max of 3 neighbours
  if(row == 0 && column ==0 ){                              //right top corner
    
   num_neighbours =copycells[row][column + 1] +  
                    copycells[row + 1 ][column]+ 
                    copycells[row + 1][column + 1];
  }
  
  else if(row == 0 && column == num_column -1){       //left top corner
    
   num_neighbours =copycells[row][column -1] +  
                    copycells[row + 1 ][column]+ 
                    copycells[row + 1][column - 1];
  }
  
  else if(row == num_row-1 && column == 0){       //right bottom corner
    
   num_neighbours =copycells[row][column +1] +  
                    copycells[row - 1 ][column]+ 
                    copycells[row -1][column +1];
  }
  
   else if(row == num_row-1 && column == num_column -1){ //left bottom corner
    
   num_neighbours =copycells[row][column -1] +  
                    copycells[row -1 ][column]+ 
                    copycells[row -1][column -1];
  }
  
  //top,bottom row blocks and right and left column blocks have max of 5 neighbours
  else if (row == 0 && column != (column == num_column -1 ? num_column -1 : 0)){  //row 0 exclude the two corners                              
  num_neighbours =  copycells[row][column + 1] + 
                    copycells[row][column -1]+ 
                    copycells[row + 1 ][column]+ 
                    copycells[row + 1][column + 1]+ 
                    copycells[row + 1][column -1];
  }
  
  else if (row != (row == num_row-1 ? num_row-1 : 0)  && column == 0){     //column 0 exclude the two corners 
  num_neighbours =  copycells[row][column + 1] + 
                    copycells[row+1][column +1]+ 
                    copycells[row - 1 ][column]+ 
                    copycells[row - 1][column + 1]+ 
                    copycells[row + 1][column];
  }
  
  else if (row == num_row-1 && column != (column == num_column -1 ? num_column -1 : 0)){  //last row exclude the two corners                              
  num_neighbours =  copycells[row][column + 1] + 
                    copycells[row][column -1]+ 
                    copycells[row -1][column]+ 
                    copycells[row -1][column + 1]+ 
                    copycells[row -1][column -1];
  }
  
  else if (row != (row == num_row-1 ? num_row-1 : 0)  && column == num_column -1){    //last column exclude the two corners
  num_neighbours =  copycells[row][column - 1] + 
                    copycells[row - 1][column -1]+ 
                    copycells[row -1][column]+ 
                    copycells[row + 1][column - 1]+ 
                    copycells[row + 1][column];
  }
  
  //maximum of 8 neighbours alive for the rest of the blocks
  else{
  num_neighbours =  copycells[row][column + 1] + copycells[row][column -1]+ 
                    copycells[row + 1 ][column]+ copycells[row -1][column]+ 
                    copycells[row -1][column -1]+ copycells[row -1][column +1]+ 
                    copycells[row + 1][column + 1]+ copycells[row + 1][column -1];
  }
  return num_neighbours;
}




void title() {
  fill(128);
  text("Conway's Game of Life", 10, 13);
   
}


//create your own cells during the start or on pause
void manualCells(boolean pause){
  if(mousePressed && pause == true){
    
     int mouse_x = int(map(mouseX, 0, width, 0, width/SizeOfCells));
        mouse_x = constrain(mouse_x, 0, width/SizeOfCells-1);
        int mouse_y = int(map(mouseY, 0, height, 0, height/SizeOfCells));
        mouse_y = constrain(mouse_y, 0, height/SizeOfCells-16);


      if (copycells[mouse_x][mouse_y]==1) {   //kill the cell if alive
        cells[mouse_x][mouse_y]=0; 
        fill(dead); 
      }
      else { 
        cells[mouse_x][mouse_y]=1;           // Make alive
        fill(alive); 
      }
    } 
    
    else if (pause && !mousePressed) {      //copy the cells once mousepressed is released 
      for (int x=0; x<num_column; x++) {
        for (int y=0; y<num_row; y++) {
          copycells[x][y] = cells[x][y];
      }
    }
  }
}

void updatetext(){
  fill(0);
  textSize(36);
  text("Game status",10,650,50);
  
    if(OnPause == true){
    fill(color(255,0,0));
    rect (250, 630, 20, 20);
  }
  else if(OnPause == false){
    fill(color(0,200,0));
    rect (250, 630, 20, 20);
  }
}
