CLASS tc_decimal_to_binary DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_integer_to_binary.

    METHODS setup.

    METHODS conv_5467_to_binary_via_intf FOR TESTING.
    METHODS converting_negative_integer  FOR TESTING.
    METHODS error_at_non_integer_input   FOR TESTING.
ENDCLASS.


CLASS tc_decimal_to_binary IMPLEMENTATION.

  METHOD setup.
    cut = NEW #( ).
  ENDMETHOD.

  METHOD conv_5467_to_binary_via_intf.
    cl_abap_unit_assert=>assert_equals(
        exp = |1010101011011|
        act = cut->zif_to_binary~convert( REF #( 5467 ) ) ).
  ENDMETHOD.

  METHOD converting_negative_integer.
    TRY.
        cut->zif_to_binary~convert( REF #( -12 ) ).
      CATCH zcx_negative_input INTO DATA(lx_error).
    ENDTRY.
    cl_abap_unit_assert=>assert_bound(
        msg = |The object should be bound!|
        act = lx_error ).
  ENDMETHOD.

  METHOD error_at_non_integer_input.
    DATA non_integer_input TYPE p LENGTH 2 DECIMALS 0.
    non_integer_input = 16.
    TRY.
        DATA(result) = cut->zif_to_binary~convert( REF #( non_integer_input ) ).
      CATCH zcx_non_integer_input INTO DATA(error).

    ENDTRY.
    cl_abap_unit_assert=>assert_bound(
        msg = |The object should be bound!|
        act = error ).
  ENDMETHOD.

ENDCLASS.
