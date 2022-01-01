CLASS zcl_binary_to_integer DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS convert IMPORTING input         TYPE string
                    RETURNING VALUE(result) TYPE i.

  PRIVATE SECTION.
    CONSTANTS c_binary_base TYPE i VALUE 2.
    CONSTANTS c_one_binary_digit TYPE i VALUE 1.
    CONSTANTS c_value_one TYPE i VALUE 1.
    CONSTANTS c_no_offset TYPE i VALUE 0.

    DATA current_power TYPE i.
    DATA binary_number TYPE string.

    METHODS save_input_as_binary_number    IMPORTING input TYPE string.

    METHODS extract_leading_digit          IMPORTING i_binary_number TYPE string
                                           RETURNING VALUE(result)   TYPE string.

    METHODS string_has_multiple_digits     IMPORTING binary_number TYPE string
                                           RETURNING VALUE(result) TYPE abap_bool.

    METHODS shorten_binary_number_left.

    METHODS compute_power_of_two_for_digit IMPORTING binary_digit  TYPE string
                                           RETURNING VALUE(result) TYPE i.

    METHODS compute_current_power_of_two RETURNING VALUE(result) TYPE i.

    METHODS increase_current_power_by_one.
ENDCLASS.



CLASS zcl_binary_to_integer IMPLEMENTATION.

  METHOD convert.
    save_input_as_binary_number( input ).
    DATA(binary_digit) = extract_leading_digit( binary_number ).
    IF string_has_multiple_digits( binary_number ).
      shorten_binary_number_left( ).
      result = convert( binary_number ).
    ENDIF.
    result = result + ( binary_digit * compute_power_of_two_for_digit( binary_digit ) ).
  ENDMETHOD.

  METHOD save_input_as_binary_number.
    binary_number = input.
  ENDMETHOD.

  METHOD extract_leading_digit.
    result  = substring( val = i_binary_number off = c_no_offset len = c_value_one ).
  ENDMETHOD.

  METHOD string_has_multiple_digits.
    result = xsdbool( strlen( binary_number ) > c_one_binary_digit ).
  ENDMETHOD.

  METHOD shorten_binary_number_left.
    SHIFT binary_number LEFT BY c_value_one PLACES.
  ENDMETHOD.

  METHOD compute_power_of_two_for_digit.
    result = binary_digit * compute_current_power_of_two( ).
    increase_current_power_by_one( ).
  ENDMETHOD.

  METHOD compute_current_power_of_two.
    result  = c_binary_base ** current_power.
  ENDMETHOD.

  METHOD increase_current_power_by_one.
    current_power = current_power + c_value_one.
  ENDMETHOD.

ENDCLASS.
