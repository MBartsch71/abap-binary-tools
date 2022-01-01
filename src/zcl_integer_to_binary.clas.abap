 CLASS zcl_integer_to_binary DEFINITION
  PUBLIC
  CREATE PUBLIC .

   PUBLIC SECTION.
     INTERFACES zif_to_binary.


   PRIVATE SECTION.
     CONSTANTS c_minimal_calculation_number TYPE i VALUE 1.
     CONSTANTS c_binary_base TYPE i VALUE 2.

     METHODS exception_at_non_integer_input IMPORTING data_reference TYPE REF TO data.

     METHODS exception_at_negative_input    IMPORTING data_reference TYPE REF TO data.

     METHODS convert_to_binary              IMPORTING number        TYPE i
                                            RETURNING VALUE(result) TYPE string.

     METHODS end_of_calculation             IMPORTING number        TYPE i
                                            RETURNING VALUE(result) TYPE abap_bool.

     METHODS initialize_result              IMPORTING number        TYPE i
                                            RETURNING VALUE(result) TYPE char1.

     METHODS calculate_quotient             IMPORTING number        TYPE i
                                            RETURNING VALUE(result) TYPE i.

     METHODS calculate_rest                 IMPORTING number        TYPE i
                                            RETURNING VALUE(result) TYPE i.

     METHODS input_is_not_integer           IMPORTING data_reference TYPE REF TO data
                                            RETURNING VALUE(result)  TYPE abap_bool.

     METHODS number_is_negative             IMPORTING number        TYPE i
                                            RETURNING VALUE(result) TYPE abap_bool.

     METHODS dereference                    IMPORTING data_reference TYPE REF TO data
                                            RETURNING VALUE(result)  TYPE i.
 ENDCLASS.



 CLASS zcl_integer_to_binary IMPLEMENTATION.

   METHOD zif_to_binary~convert.
     exception_at_non_integer_input( data_reference ).
     exception_at_negative_input( data_reference ).

     result = convert_to_binary( dereference( data_reference ) ).
   ENDMETHOD.

   METHOD exception_at_non_integer_input.
     IF input_is_not_integer( data_reference ).
       RAISE EXCEPTION TYPE zcx_non_integer_input.
     ENDIF.
   ENDMETHOD.

   METHOD exception_at_negative_input.
     IF number_is_negative( dereference( data_reference ) ).
       RAISE EXCEPTION TYPE zcx_negative_input.
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
     result = xsdbool( number = c_minimal_calculation_number ).
   ENDMETHOD.

   METHOD initialize_result.
     result = CONV char1( number ).
   ENDMETHOD.

   METHOD calculate_quotient.
     result = number DIV c_binary_base.
   ENDMETHOD.

   METHOD calculate_rest.
     result = number MOD c_binary_base.
   ENDMETHOD.

   METHOD input_is_not_integer.
     result = xsdbool( cl_abap_typedescr=>describe_by_data_ref( data_reference )->type_kind <> cl_abap_typedescr=>typekind_int ).
   ENDMETHOD.

   METHOD number_is_negative.
     result = xsdbool( number < 0 ).
   ENDMETHOD.

   METHOD dereference.
     ASSIGN data_reference->* TO FIELD-SYMBOL(<number>).
     result = <number>.
   ENDMETHOD.

 ENDCLASS.
