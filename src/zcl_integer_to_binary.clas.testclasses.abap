CLASS tc_decimal_to_binary DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_integer_to_binary.

    METHODS setup.

    METHODS convert_5467_to_binary      FOR TESTING.
    METHODS converting_negative_integer FOR TESTING.

ENDCLASS.


CLASS tc_decimal_to_binary IMPLEMENTATION.

  METHOD setup.
    cut = NEW #( ).
  ENDMETHOD.

  METHOD convert_5467_to_binary.
    cl_abap_unit_assert=>assert_equals(
        exp = |1010101011011|
        act = cut->convert( 5467 ) ).
  ENDMETHOD.

  METHOD converting_negative_integer.
    TRY.
        cut->convert( -12 ).
      CATCH cx_negative_input INTO DATA(lx_error).
    ENDTRY.
    cl_abap_unit_assert=>assert_bound(
        msg = |The object should be bound!|
        act = lx_error ).
  ENDMETHOD.

ENDCLASS.
