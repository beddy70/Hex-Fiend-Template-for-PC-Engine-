#little_endian
big_endian
if [catch {

	while {![end]} {
		section -collapsed "" {
			set i 0
			while { $i<16 } {
				set pal_index [ expr { ( [pos] /  32 ) } ] 
				section  "" {
				
						set color_index [ expr { [pos] % 32  / 2} ] 

						set color  [uint16]
				 		set red   [ expr { $color >> 3 & 7} ]
				 		set green [ expr { $color >> 6 & 7} ]
				 		set blue  [ expr { $color & 7} ]
						set result  [string toupper " RGB($red,$green,$blue)"]  

						incr i
				
					sectionname  "Color $color_index ->"
			 		sectionvalue $result
				}
				sectionname  "Palette $pal_index" 
			}
		}
	}
 
}] {
    puts $errorInfo
}