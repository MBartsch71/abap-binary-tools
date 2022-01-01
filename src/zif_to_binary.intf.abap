INTERFACE zif_to_binary
  PUBLIC.
  METHODS convert IMPORTING data_reference TYPE REF TO data
                  RETURNING VALUE(result)  TYPE string.

ENDINTERFACE.
