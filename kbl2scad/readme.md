kbl2scad
========
Original project from:
https://bitbucket.org/afqueiruga/kbl2scad/src/master/


Converts raw data from keyboard-layout-editor.com into OpenSCAD code.

Target use case: auto generating plates for laser cutting. 
May be useful for 3D printing, but the data is only planar.

Due credit goes to technomancy's Atreus,
https://github.com/technomancy/atreus
for the inspiration as well as Jack and Pierre's Planck,
https://github.com/pcarrier/planck
for the key model and even more inpiration.


Usage
-----

Python is required. You don't need OpenSCAD to use the program, but it's not very useful without it!


1. Go to keyboard-layout-editor.com, design your keyboard, and copy and paste the raw data into a text file.
2. Run from the command line.
```
python kbl2scad.py my_layout_file -o keys.scad
```
3. Import the generated file into OpenSCAD. See the file "default_plates.scad" for a usage examle. Feel free to just modify this file as you want.
4. Use "preview()" to look at a 3d rendering, where the argument lets you set an exploded view. Use "cuts()" to actually make the cuts.
5. Hit compile "Compile and Render" and then do "Export as DXF...". Now you're ready to import and lay out your files to send to your laser cutter!


Screenshots
-----------

One of the defaults from keyboard-layout-editor.com:

![keyboard layout](https://bitbucket.org/afqueiruga/kbl2scad/raw/master/img/example-gb-ccng.png)

The planck, from http://planckkeyboard.com

![keyboard layout](https://bitbucket.org/afqueiruga/kbl2scad/raw/master/img/example-planck.png)

My own custom split keyboard, using a lightly modified version of default_plates.scad:

![keyboard layout](https://bitbucket.org/afqueiruga/kbl2scad/raw/master/img/example-quail.png)

The layout data for this guy is included in the test_cases directory.


TODO:
-----

- Switch over to using SolidPython to stop reinventing the wheel.
+ (Done) Generate the plate.
+ (Done) Generate spacers and back plate.
+ (Done) Figure out how to autoplace switch holes...
- (Done) Add in the default OpenSCAD file that makes plates and holes.
- Handle rotations of keys.
- Generate stabilizer mounts.
- (Done) Add examples.
- Handle awkward keys like ISO enter.

License
-------

Copyright (c) 2014, Alejandro Francisco Queiruga

This work is released under the three-clause BSD License. See the file LICENSE for the full text.
