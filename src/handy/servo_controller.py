#!/usr/bin/env python
import rospy
import roslib
import pigpio
from std_msgs.msg import Float64

pi = pigpio.pi()

def shoulder_controller(msg):
	pi.set_servo_pulsewidth(26,msg.data)

def elbow_controller(msg):
	pi.set_servo_pulsewidth(19,msg.data)

def wrist_controller(msg):
	pi.set_servo_pulsewidth(13,msg.data)

def finger_controller(msg):
	pi.set_servo_pulsewidth(9,msg.data)

rospy.init_node('servo_controller',anonymous=True)
rospy.Subscriber("/angle_shoulder",Float64,shoulder_controller)
rospy.Subscriber("/angle_elbow",Float64,elbow_controller)
rospy.Subscriber("/angle_wrist",Float64,wrist_controller)
rospy.Subscriber("/angle_finger",Float64,finger_controller)

rospy.spin()
