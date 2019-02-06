# Work In Progress

This documentation relates to code that is not yet written.

For a package that has a chance of working, see: https://github.com/simonster/NaturalSort.jl

# NaturalStrings

[![Build Status](https://travis-ci.com/perrutquist/NaturalStrings.jl.svg?branch=master)](https://travis-ci.com/perrutquist/NaturalStrings.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/perrutquist/NaturalStrings.jl?svg=true)](https://ci.appveyor.com/project/perrutquist/NaturalStrings-jl)
[![Codecov](https://codecov.io/gh/perrutquist/NaturalStrings.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/perrutquist/NaturalStrings.jl)

NaturalStrings is a Julia package for treating numbers in strings as if they were single "characters".

This allows for a [natural sort order](https://en.wikipedia.org/wiki/Natural_sort_order) where `NaturalString("item 9")` sorts before `NaturalString("item 10")`.

Iterating over a `NaturalString{S,T}` will yield `Char` for characters and `T` for numbers, where `T` can either be an `Integer` type or `SubString`. The latter is the default, and works with numbers of any length. (`S` is the type of the wrapped `AbstractString`.)

The `length` of a `NaturalString` is computed counting all-digit substrings as single characters. It can therefore be smaller than the length of the wrapped string.

## Examples

```julia
julia> sort(["a100", "a10", "a11", "a9"], by=NaturalString)
```

## Performance

The `NaturalString` type is just a thin wrapper. Parsing takes place each time that the string is iterated over. Therefore indexing operations (`s[i]`) should be avoided in favour of iteration (`for x in s`).

## Notes

The minus sign (`-`) and the period (`.`) are treated as a characters rather than parts of numbers, so `NaturalString("item-9")` sorts before `NaturalString("item-10")` and  `NaturalString("v0.9")` sorts before `NaturalString("v0.10")`.

There is currently no support for numbers in bases other than 10.

There is currently no i18n support (e.g. digits other than `0` ... `9`).
