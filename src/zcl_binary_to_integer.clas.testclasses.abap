class tc_binary_to_integer definition final for testing
  duration short
  risk level harmless.

  private section.
   data cut type ref to zcl_binary_to_integer.

   methods setup.
   methods convert_1001_bin_decimal for testing.
endclass.


class tc_binary_to_integer implementation.

  method setup.
    cut = new #( ).
  endmethod.

  method convert_1001_bin_decimal.
    cl_abap_unit_assert=>assert_equals(
        exp = 5467
        act = cut->convert( |1010101011011| ) ).
  endmethod.

endclass.
