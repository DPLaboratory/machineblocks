#!/usr/bin/python

from argparse import ArgumentParser
import sys
import re

"""
See readme.md
"""

#
# Parse the arguments
#
parser = ArgumentParser(description="kbl2scad. Convert keyboard-layout-editor.com data into \
holes in OpenSCAD.")
parser.add_argument('iname',nargs='?',default=None)
parser.add_argument('-o',nargs='?',default=None)
args = parser.parse_args()

in_file  = open(args.iname,"r") if args.iname else sys.stdin
out_file = open(args.o,"w") if args.o else sys.stdout


#
# Write in the headers
#
temp_file = open("template.scad","r")
for l in temp_file:
    out_file.write(l)
temp_file.close()

out_file.write("key_spacing = {0};\n".format(14+5));

#
# Build the key list.
#
linenum=0
key_width=14+5
key_height=14+5
y=0.0
key_list = []
bbox = [100.0,100.0,-100.0,-100.0]
color = "Grey"
for line in in_file:
    x = 0.0
    w=1
    h=1
    y -= 1 #float(linenum)
    linenum+=1
    
    matches = re.findall('({.*?}|(["])(?:(?=(\\\\?))\\3.)*?\\2)',line, re.M|re.I)
    for m in matches:
        if m[0][0]=='"':
            # Place a key
            key_list.append([x,y,w,h,color])
            
            bbox[0] = min(bbox[0],x-0.5)
            bbox[1] = min(bbox[1],y-h/2-0.5)
            bbox[2] = max(bbox[2],x+w-0.5)
            bbox[3] = max(bbox[3],y+h-0.5)
            x=x+w
            w=1
            h=1
        elif m[0][0]=='{':
            coms = re.findall('(([^{,]+):([^},]+))',m[0],re.M|re.I)
            for c in coms:
                if c[1]=='x':
                    x=x+float(c[2])
                if c[1]=='y':
                    y=y-float(c[2])
                if c[1]=='w':
                    w=float(c[2])
                if c[1]=='h':
                    h=float(c[2])
                if c[1]=='c':
                    color = "["+\
                      str(int("0x"+c[2][2:4],base=0)/255.0)+","+\
                      str(int("0x"+c[2][4:6],base=0)/255.0)+","+\
                      str(int("0x"+c[2][6:8],base=0)/255.0)+"]"

centerx = 0.5*(bbox[2]+bbox[0])
centery = 0.5*(bbox[3]+bbox[1])
bbox[3] = bbox[3]-bbox[1]
bbox[2] = bbox[2]-bbox[0]
for i in range(len(key_list)):
    key_list[i][0] -= centerx;
    key_list[i][1] -= centery;
bbox[0] -= centerx;
bbox[1] -= centery;

#
# Write the switch hole module
#
out_file.write("module my_key_holes(use_notches=true) {\n");
for x,y,w,h,c in key_list:
    out_file.write("switch_hole([{0},{1}],use_notches);\n".format(
        (x+(w-1.0)/2.0)*key_width,
        (y-(h-1.0)/2.0)*key_height ) )
out_file.write("}\n");

#
# Write the key preview to the module
#
out_file.write("module my_key_previews(use_notches=true) {\n");
for x,y,w,h,c in key_list:
    out_file.write("translate([{0}, {1}]) m_key({2}*18.415+({2}-1)*0.6, {3}*18.415+({3}-1)*0.6,{4});\n".format(
        (x+(w-1.0)/2.0)*key_width,
        (y-(h-1.0)/2.0)*key_height,
        w, h, c)
        )
out_file.write("}\n");

#
# Write a function that returns the bounding box.
#
out_file.write("function bbox() = {0};\n".format(bbox))

# out_file.write("my_keys(true);\n");
out_file.close()
