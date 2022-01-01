CLASS tc_binary_to_integer DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_from_binary.

    METHODS setup.
    METHODS convert_1001_bin_decimal FOR TESTING.

ENDCLASS.


CLASS tc_binary_to_integer IMPLEMENTATION.

  METHOD setup.
    cut = NEW zcl_binary_to_integer( ).
  ENDMETHOD.

  METHOD convert_1001_bin_decimal.
    DATA(result) = cut->convert( |1010101011011| ).
    ASSIGN result->* TO FIELD-SYMBOL(<result>).

    cl_abap_unit_assert=>assert_equals(
        exp = 5467
        act = <result> ).
  ENDMETHOD.

ENDCLASS.
