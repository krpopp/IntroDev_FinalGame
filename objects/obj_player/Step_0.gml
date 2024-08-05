/// @description Insert description here
// You can write your code in this editor


//all instance variables are declared in the "variable definitions" window
//you should change these values so the feel better matches the original game!!!

//slow down the x speed by 90%
x_vel *= 0.9;

//add gravity to the y velocity
y_vel += grav;

//add the current speed to the leftover speed from the last frame
r_x += x_vel;
r_y += y_vel;

//round that distance
//these are the pixels we need to move this frame
var to_move_x = round(r_x);
var to_move_y = round(r_y);

//remove the rounded amount so that we have some leftover speed
r_x -= to_move_x;
r_y -= to_move_y;

//find the distance between the two walls w/ some padding
var dist_to_r_wall = room_width - x - 8;
var dist_to_l_wall = x - 8;

//find the y direction we're moving
var dir = sign(to_move_y);

//if we're past the right wall
if(to_move_x >= dist_to_r_wall)
{
	//push back the player
	//reverse the speed
	//remove all remaining x speed values
	x = room_width - 9;
	x_vel = abs(x_vel) * -1;
	r_x = 0;
	//if we're past the left wall
} else if(to_move_x < -dist_to_l_wall)
{
	//push back the player
	//reverse the speed
	//remove all remaining x speed values
	x = 9;
	x_vel = abs(x_vel);
	r_x = 0;
} else
{
	//if we are within the room's bounds
	//add the amount we need to move to our x position
	x += to_move_x;
}

//as long as we have pixels left to move
while(to_move_y != 0)
{
	//declare variables to check if we're colliding
	//and what we're colliding with
	var colliding = false;
	var collide_with = noone;
	
	//only check for collisions if we're moving down
	if(dir >= 0)
	{
		//this is where i'd put code to collide w/ another player!
		//but i am not :(
		
		//check if we will collide with the floor (burgers)
		collide_with = instance_place(x, y + dir, obj_burger);
		if(collide_with != noone)
		{
			//if we aren't already overlapping with that instance
			if(place_meeting(x, y, collide_with) == false)
			{
				//set colliding to true
				colliding = true;
			}
		}
	}
	
	//if we didn't collide w/ anything
	if(!colliding)
	{
		//move one pixel
		y += dir;
		//remove that pixel from the distance we need to move this frame
		to_move_y -= dir;
	} else
	{
		//if we DID collide
		//move one pixel
		//add bounce_vel to our y_vel to bounce that bad boy upwards
		//and remove our leftover, fractional pixels
		//and get outta the loop
		y = y + dir;
		y_vel = bounce_vel;
		r_y = 0;
		break;
	}
}


//add acceleration to x speed based on input
if(keyboard_check(ord(left_key)))
{
	x_vel -= accel;
}
if(keyboard_check(ord(right_key)))
{
	x_vel += accel;
}

