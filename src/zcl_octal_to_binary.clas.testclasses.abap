CLASS ltc_octal_to_binary DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_to_binary.

    METHODS setup.
    METHODS convert_4130_to_binary FOR TESTING.
ENDCLASS.


CLASS ltc_octal_to_binary IMPLEMENTATION.

  METHOD convert_4130_to_binary.
    cl_abap_unit_assert=>assert_equals(
        exp = |100001011000|
        act = cut->convert( REF #( 4130 ) ) ).
  ENDMETHOD.

  METHOD setup.
    cut = NEW zcl_octal_to_binary( ).
  ENDMETHOD.

ENDCLASS.
