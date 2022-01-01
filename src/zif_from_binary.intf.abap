INTERFACE zif_from_binary
  PUBLIC.
  METHODS convert IMPORTING input         TYPE string
                  RETURNING VALUE(result) TYPE REF TO data.

ENDINTERFACE.
