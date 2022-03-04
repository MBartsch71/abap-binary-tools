CLASS zcl_octal_to_binary DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_to_binary.

  PRIVATE SECTION.
    DATA mv_number_read_completely TYPE abap_bool.

    METHODS convert_to_binary            IMPORTING number        TYPE string
                                                   index         TYPE i
                                         RETURNING VALUE(result) TYPE string.

    METHODS dereference                  IMPORTING data_reference TYPE REF TO data
                                         RETURNING VALUE(result)  TYPE string.

    METHODS get_3_digit_binary           IMPORTING char          TYPE string
                                         RETURNING VALUE(result) TYPE char3.

    METHODS number_not_read_completely   IMPORTING number        TYPE string
                                                   index         TYPE i
                                         RETURNING VALUE(result) TYPE abap_bool.

ENDCLASS.

CLASS zcl_octal_to_binary IMPLEMENTATION.

  METHOD zif_to_binary~convert.
    DATA(number) = dereference( data_reference ).

    result = convert_to_binary( number = number
                                index  = 0 ).
  ENDMETHOD.

  METHOD convert_to_binary.
    IF number_not_read_completely( number = number index  = index ).
      result = convert_to_binary( number = number index = index + 1 ).
    ENDIF.
    DATA(char) = substring( val = number off = index len = 1 ).
    DATA(binary) = get_3_digit_binary( char ).
    result = binary && result.
  ENDMETHOD.

  METHOD dereference.
    ASSIGN data_reference->* TO FIELD-SYMBOL(<number>).
    result = <number>.
    CONDENSE result NO-GAPS.
  ENDMETHOD.

  METHOD get_3_digit_binary.
    result = SWITCH #( char WHEN 0 THEN |000|
                            WHEN 1 THEN |001|
                            WHEN 2 THEN |010|
                            WHEN 3 THEN |011|
                            WHEN 4 THEN |100|
                            WHEN 5 THEN |101|
                            WHEN 6 THEN |110|
                            WHEN 7 THEN |111| ).
  ENDMETHOD.

  METHOD number_not_read_completely.
    IF mv_number_read_completely = abap_false.
      mv_number_read_completely = xsdbool( index = strlen( number ) - 1 ).
    ENDIF.
    result = xsdbool( mv_number_read_completely = abap_false ).
  ENDMETHOD.

ENDCLASS.
