Toy Robot Simulator
===================

This is an implementation of the Toy Robot simulator. The challenge can be stated simply as:

### Description:
The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
There are no other obstructions on the table surface.
The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. 
Any movement that would result in the robot falling from the table must be prevented; however further valid movement commands must still be allowed.

### Setup

Simply run 

    $ bundle install

### Testing

Test are include in the ```spec/unit``` directory and can be run by:

    $ bundle exec rake

Output is available in

    spec/reports/index.html
    coverage/index.html

### Running the robot

A CLI is provided to allow ad-hoc testing of the toy-robot. The CLI is implemented in pry and can be run as follows:

    $ bundle exec ruby toy-robot.rb

This launches a pry session with a (5x5) ```Board``` object setup. The commands available can be listed using the toy_robot_help function. 
    > place x, y, heading
      Places a robot on the board at the location specified.
      x – the x coordinate
      y – the y coordinate
      heading – valid heading (‘north’, ‘south’, ‘east’, ‘west’)

    > move
      Moves the robot along the current heading

    > left
       Turn the robot to the left.

    > right
       Turn the robot to the right.

    > report
        Output the current location of the robot.

### Toy-Robot API

The current state of the robot is represented and manipulated by the ```Board``` class. This class provides all the methods above (the CLI just proxies them through to an instance of ```Board```).

All methods except ```report``` return self so as to allow chaining. For example

    Board.new(5,5).place(0,0,:north).robot_move.robot_left.report
    > “1,3,WEST”

### Design Notes

The key design decision to mention is that the ```Robot``` class is immutable. The ```Robot``` class represents the internal state of a robot (x,y and heading) as well as provides methods for "moving" the robot. However, these methods never alter the state and instead return a new instance of the robot. 

State mutation is managed by the ```Board``` class and is implemented as a stack of ```Robot```s with the top robot being the current position.

This pattern allows the following:
* A clear separation of responsibilities between the Board and Robot. The Robot knows its state and how to move; the Board knows that it has a robot and the bounds of the board.
* The intersection of responsibility (the Robot being prevented from moving off the board) is implemented by moving the Robot and then checking if the new Robot is within the bounds of the Board. If so, the state is updated, otherwise the Robot is discarded.
* By keeping previous states it becomes trivial to implement ```undo``` and ```replay``` functions. (TODO)

