# abap-binary-tools
This is a collection of binary tools for ABAP. 

Due to the lack of nice build-in classes for working with binary values, I decided to develop some useful converters as well as capabilities to calculate with binary numbers.

Please feel free to extend, comment or request new functionality.

## Converters
- [Integer to Binary](src/zcl_integer_to_binary.clas.abap)  
- [Binary to Integer](src/zcl_binary_to_integer.clas.abap)  

### Usage 
- for implementation use interfaces
	- [if_to_binary](src/zif_to_binary.intf.abap)  
	- [if_from_binary](src/zif_from_binary.intf.abap)  

