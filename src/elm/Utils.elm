module Utils exposing (currency)

import FormatNumber exposing (format)
import FormatNumber.Locales exposing(Locale)

realLocale : Locale
realLocale =
    Locale 2 "." "," "−" "" "" ""

currency : Float -> String
currency number =
    "R$ " ++ format realLocale number
