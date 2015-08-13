# My_GameOfLife-Simulator

Rules of Game of Life Simulator:

Let’s check the rule of John Conway’s original Game of Life.

1.For a space that is 'populated':

      	Each cell with one or no neighbours dies, as if by loneliness.
      	Each cell with four or more neighbours dies, as if by overpopulation.
     	Each cell with two or three neighbours survives
    
2.For a space that is 'empty' or ‘unpopulated':

    	Each cell with three neighbours becomes populated.


Method:

1.Draw a grid of small cells (cell size = 8) in a 600x600 background

2.Make two grids, one as a backup

3.Make visit to each cells of the backup grid and calculate the number of alive neighbours:

	- Max of 3 neighbours for the cells that located at the corner of the grid
	- Max of 5 neighbours for the cells that (other than corner cells) located at the edge of the grid
	- Max of 8 neighbours for the rest of the cells
	
4.If the number of neighbours of an active cell is below than 2 and more than 3, make the cell inactive (in original grid) 

5.If the number of neighbours of an inactive cell is equal to three, make cell to active (in original grid)

The simulator runs once you press space bar and if you wish to  disturb the cells, click on the cells to kill or make a cell to see the resulting reaction. 

I have programmed some of the patterns. Press q,w,e or r to randomly generate cells. Make your own pattern by clicking on the cells during the pause mode. 

A small box at the bottom of the grid indicates the status of the game. Feel free to experiment the simulator.
