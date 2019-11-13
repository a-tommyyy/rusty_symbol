# with a argument typed Symbol
:symbol.start_with?(:sym) #=> true
:symbol.start_with?(:bol) #=> false

:symbol.end_with?(:bol) #=> true
:symbol.end_with?(:sym) #=> false

# with multiple arguments typed Symbol
:symbol.start_with?(:foo, :sym) #=> true
:symbol.start_with?(:foo, :bol) #=> false

:symbol.end_with?(:foo, :bol) #=> true
:symbol.end_with?(:foo, :sym) #=> false
