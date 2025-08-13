#little_endian
big_endian


if [catch {

	# Déclaration
	array set tile {}

	set tileNum 0

	while {![end]} {
		# Initialisation à 0
		for {set x 0} {$x < 8} {incr x} {
		    for {set y 0} {$y < 8} {incr y} {
		        set tile($x,$y) 0
		    }
		}
		section -collapsed "" {
			
			sectionname  "Tile $tileNum " 

			# plan 1 & 2	
			
			for {set j 0} {$j < 8} {incr j} {
					set data0 [uint8] 
					set data1 [uint8]	

					for  {set k 0} {$k < 8} {incr k} {
						set val  [ expr {  ( ( $data1 & (0x80 >> $k) ) >> ( 7 - $k ) ) << 1  | (( $data0  & (0x80>> $k) )>> ( 7 - $k )) } ]
						set tile($j,$k) $val
					}
			}
		
			# plan 3 & 4
	
			for {set j 0} {$j < 8} {incr j} {
					set data2 [uint8] 
					set data3 [uint8]

					for  {set k 0} {$k < 8} {incr k} {
						set val  $tile($j,$k)
						set val  [ expr {  $val | ((( ( $data3 & (0x80 >> $k) ) >> ( 7 - $k ) ) << 1  | (( $data2  & (0x80>> $k) )>> ( 7 - $k )) )<<2)} ]
						set tile($j,$k) $val
					}
			}
		
			for {set j 0} {$j < 8} {incr j} {
		
				set linetile ""
				for {set i 0} {$i < 8} {incr i} {

					set val $tile($j,$i)
					
					if { $val == 0} {
						append linetile "_" 
					} else {
						append linetile [ string toupper [format %1x $val ] ]
					}
				}
				entry "line $j" $linetile 

			}
		
			incr tileNum 
		}
	
		
		
	}
		
	
 
}] {
    puts $errorInfo
}