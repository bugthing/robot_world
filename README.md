# RobotWorld

A gem that meets the requirements from a coding challenge

## Installation

Install it like so:

    $ git clone git@github.com:bugthing/robot_world.git
    $ cd robot_world
    $ bundle

## Usage

    $ ./bin/robot-world help move_robot

Simple example:

    $ echo -e "5 3\n1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL" | ./bin/robot-world

Run the tests:

    $ rspec
