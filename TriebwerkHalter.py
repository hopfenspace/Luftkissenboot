from solid import *
from solid.utils import *

def pipe(innerRadius,thickness,height):
    return difference()(
        cylinder(r=innerRadius + thickness,h=height),
        cylinder(r=innerRadius,h=height)
    )

def trapetz(widtherWidth,smallerWidth,thickness,height):
    return rotate([0,0,45]) (
        cylinder(r1=widtherWidth,r2=smallerWidth,h=height,center=True,segments=4)
        )

def screw_holder

d = union()(
    trapetz(10,5,10,10),
    pipe(65,4,40)
)














print(scad_render(d))


scad_render_to_file(d, 'triebwerk.scad', file_header = '$fn = 100;')
