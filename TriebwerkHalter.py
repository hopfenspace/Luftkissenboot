from solid import *
from solid.utils import *

pipeRadius = 65
pipe_height = 60
screw_width = 20
screw_height = 5


def pipe(innerRadius,thickness,height):
    return difference()(
        cylinder(r=innerRadius + thickness,h=height),
        cylinder(r=innerRadius,h=height)
    )

def trapetz(length,thickWidth,smallWidth,height):
    return polyhedron(points=[[0,0,0], [0,(thickWidth-smallWidth)/2,height],
     [0,(thickWidth-smallWidth)/2 + smallWidth,height], [0,thickWidth,0],
    [length,0,0], [length,(thickWidth-smallWidth)/2,height], 
    [length,(thickWidth-smallWidth)/2 + smallWidth,height], [length,thickWidth,0]],
               faces=[[0,1,2,3],[4,5,6,7],[0,3,4,7],
               [1,2,5,6],
               [0,4,5,1],[3,4,6,7],[2,3,6,7]])

def screw_holder(width,height):
    return difference()(
        cube([width,width,height]),
            translate([width/2,width/2,0])(
                cylinder(r=3,h=height)
            )
        )


d = union()(
    trapetz(20,15,10,10),
    translate([pipeRadius,-screw_width/2,0])(
        screw_holder(screw_width,screw_height)
    ),
    translate([-pipeRadius-screw_width,-screw_width/2,0])(
        screw_holder(screw_width,screw_height)
    ),
    translate([-screw_width/2,-pipeRadius-screw_width,0])(
        screw_holder(screw_width,screw_height)
    ),
    translate([-screw_width/2,pipeRadius,0])(
        screw_holder(screw_width,screw_height)
    ),
    difference()(
        pipe(pipeRadius,5,pipe_height),
        translate([-pipeRadius,0,pipe_height])(
            rotate([180,0,45])(
                cylinder(r1=15,r2=10,h=10,segments=4)
            )
        ),
        translate([pipeRadius,0,pipe_height])(
            rotate([180,0,45])(
                cylinder(r1=15,r2=10,h=10,segments=4)
            )
        )
    )
)



scad_render_to_file(d, 'triebwerk.scad', file_header = '$fn = 500;')
