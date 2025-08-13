#little_endian
big_endian
if [catch {

	while {![end]} {
		section -collapsed "" {
			set i 0
			while { $i<32 } {
				set line_num [ expr { ( [pos] /  64 ) } ] 
				section  "" {
				
				

					set data  [uint16]
			 		set palette   [ expr { ( $data  & 0xF000 ) >> 12 } ]
			 		set addr [ expr { ( $data & 0x0FFF) << 4 } ]
					set result  [string toupper "ADDR= \$[format %04x $addr]"]  
			
				
				
					sectionname  "COL= $i PAL=$palette "
			 		sectionvalue $result
			 		incr i
				}
				sectionname  "line $line_num" 
			}
		}
	}
 
}] {
    puts $errorInfo
}