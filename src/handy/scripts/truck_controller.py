#!/usr/bin/env python

import rospy
import roslib
import pigpio
from std_msgs.msg import Int32

pi = pigpio.pi()

right_red = 22
right_black = 10
left_red = 27
left_black = 9

pi.set_mode(right_red,pigpio.OUTPUT)
pi.set_mode(right_black,pigpio.OUTPUT)
pi.set_mode(left_red,pigpio.OUTPUT)
pi.set_mode(left_black,pigpio.OUTPUT)

pi.write(right_red,1)

def left_wheel(msg):
    if(msg == 1):
        pi.write(left_red,1)
        pi.write(left_black,0)
    elif(msg == -1):
        pi.write(left_red,0)
        pi.write(left_black,1)
    else:
        pi.write(left_red,0)
        pi.write(left_black,0)

def right_wheel(msg):
    if(msg == 1):
        pi.write(right_red,1)
        pi.write(right_black,0)
    elif(msg == -1):
        pi.write(right_red,0)
        pi.write(right_black,1)
    else:
        pi.write(right_red,0)
        pi.write(right_black,0)

rospy.init_node('truck_controller'anonymous=True)
rospy.Subscriber("/left_wheel",Int32,left_wheel)
rospy.Subscriber("/right_wheel",Int32,right_wheel)

rospy.spin()
