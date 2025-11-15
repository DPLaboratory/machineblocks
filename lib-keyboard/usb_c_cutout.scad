// usb_c_cutout.scad
// Modulo parametrico per creare un'apertura per porta USB Type-C
// Uso: in un `difference()` posiziona `usb_c_cutout()` dove vuoi il foro.
// Parametri principali: larghezza, altezza del connettore, clearance, fillet (angoli arrotondati), profondità.

$fn = 64; // risoluzione per gli arrotondamenti

// 2D: rettangolo con angoli arrotondati (minkowski con cerchio)
module rounded_rect_2d(w, h, r) {
    if (r <= 0) {
        square([w, h], center=true);
    } else {
        minkowski() {
            // riduco la square di 2r per lasciare spazio per il cerchio
            square([max(0, w - 2*r), max(0, h - 2*r)], center=true);
            circle(r=r);
        }
    }
}

// Modulo principale: crea il solido da sottrarre per ottenere il foro USB-C
// port_w, port_h: dimensioni nominali del connettore (mm)
// clearance: gap intorno al connettore per tolleranze (mm)
// fillet: raggio angoli arrotondati (mm)
// depth: profondità di estrusione (mm) - impostare >= spessore parete
// center: se true, il cutout è centrato sull'origine XY
module usb_c_cutout(port_w = 9.5, port_h = 4, clearance = 0.25, fillet = 2, depth = 6, center = true) {
    w = port_w + 2*clearance;
    h = port_h + 2*clearance;

    if (center) {
        translate([0,0,0])
            linear_extrude(height=depth, center=false)
                rounded_rect_2d(w, h, fillet);
    } else {
        linear_extrude(height=depth, center=false)
            rounded_rect_2d(w, h, fillet);
    }
}

module usb_c_hole(width = 20, depth = 10, height=8-0.2, fillet = 2, perimeter = 2) {
    
    difference() 
    {
        linear_extrude(height=height, center=false)
            rounded_rect_2d(width, depth, fillet);

        translate([0,0,perimeter]) 
         linear_extrude(height=height-perimeter, center=false)
          rounded_rect_2d(width-perimeter, depth-perimeter, fillet);

        usb_c_cutout(depth = depth+1);
    }   
}

module usb_c_hole_cut(width = 20, depth = 10, height=8, fillet = 2, perimeter = 2) {
    linear_extrude(height=height, center=false)
        rounded_rect_2d(width, depth, fillet);
}

// Esempio rapido: scatola con foro USB-C
module example_box(box_w = 40, box_h = 24, box_d = 12, port_pos = [20, 12, 0]) {
    difference() {
        // box (parte solida)
        translate([0, 0, 0]) cube([box_w, box_h, box_d], center=false);

        // posiziona il cutout; il modulo è centrato sull'origine XY per default,
        // quindi spostiamo l'origine al centro del foro desiderato
        translate([port_pos[0], port_pos[1], port_pos[2]])
            // estrusione leggermente maggiore della profondità della scatola per pulire
            usb_c_cutout(depth = box_d + 1);
    }
}

// Se invochi questo file direttamente in OpenSCAD, attiva l'esempio:

// Esempio: renderizza la scatola con foro
//example_box();

