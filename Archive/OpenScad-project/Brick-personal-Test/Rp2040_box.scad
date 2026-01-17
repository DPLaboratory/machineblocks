//import("../Rp2040.stl", convexity=3, center=false);

// === Parametri da impostare ===
stl_file = "../SRL/Rp2040.stl";   // Nome del file STL
size_x = 26.15;               // Larghezza del modello (asse X)
size_y = 17.9;                // Profondità del modello (asse Y)
size_z = 6.1;                // Altezza del modello (asse Z)

//m = measure() import(stl_file);

// Mostra a console i dati misurati
//echo(m);

// === Script per centrare ===
translate([100, 98, 0])
    import(stl_file, convexity=3);