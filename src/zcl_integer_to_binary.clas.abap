 CLASS zcl_integer_to_binary DEFINITION
  PUBLIC
  CREATE PUBLIC .

   PUBLIC SECTION.
     METHODS convert IMPORTING number        TYPE i
                     RETURNING VALUE(result) TYPE string.
   PRIVATE SECTION.
     CONSTANTS minimal_number_of_calculation TYPE i VALUE 1.

     METHODS convert_to_binary       IMPORTING number        TYPE i
                                     RETURNING VALUE(result) TYPE string.

     METHODS calculate_quotient      IMPORTING number        TYPE i
                                     RETURNING VALUE(result) TYPE i.

     METHODS calculate_rest          IMPORTING number        TYPE i
                                     RETURNING VALUE(result) TYPE i.

     METHODS end_of_calculation      IMPORTING number        TYPE i
                                     RETURNING VALUE(result) TYPE abap_bool.

     METHODS initialize_result       IMPORTING number        TYPE i
                                     RETURNING VALUE(result) TYPE char1.

     METHODS abort_at_negative_input IMPORTING number TYPE i..

 ENDCLASS.


 CLASS zcl_integer_to_binary IMPLEMENTATION.

   METHOD convert.
     abort_at_negative_input( number ).
     result = convert_to_binary( number ).
   ENDMETHOD.

   METHOD abort_at_negative_input.
     IF number < 0.
       RAISE EXCEPTION TYPE cx_negative_input.
     ENDIF.
   ENDMETHOD.

   METHOD convert_to_binary.
     IF end_of_calculation( number ).
       result = initialize_result( number ).
       RETURN.
     ENDIF.
     result = convert_to_binary( calculate_quotient( number ) ).
     result = |{ result }{ calculate_rest( number ) }|.
   ENDMETHOD.

   METHOD end_of_calculation.
     result = xsdbool( number = minimal_number_of_calculation ).
   ENDMETHOD.

   METHOD initialize_result.
     result = CONV char1( number ).
   ENDMETHOD.

   METHOD calculate_quotient.
     result = number DIV 2.
   ENDMETHOD.

   METHOD calculate_rest.
     result = number MOD 2.
   ENDMETHOD.


 ENDCLASS.
