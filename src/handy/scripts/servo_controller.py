#!/usr/bin/env python

import rospy
import roslib
import pigpio

pi = pigpio.pi()

def shoulder_controller(msg):
	pi.set_servo_pulsewidth(26,msg)

def elbow_controller(msg):
	pi.set_servo_pulsewidth(19,)

def wrist_controller(msg):
	pi.set_servo_pulsewidth(13)

def finger_controller(msg):
	pi.set_servo_pulsewidth(9,)

rospy.init_node('servo_controller',anonymous=True)
rospy.Subscriber("/angle_shoulder",,shoulder_controller)
rospy.Subscriber("/angle_elbow",,elbow_controller)
rospy.Subscriber("/angle_wrist",,wrist_controller)
rospy.Subscriber("/angle_finger",,finger_controller)

rospy.spin()

