module NaturalStrings

export NaturalChar, NaturalString

import Base: codepoint, read, write, ncodeunits, codeunnit, isvalid

struct NaturalChar{T} <: AbstractChar
    parent::T
end

codepoint(c::NaturalChar{<:AbstractChar}) = codepoint(c.parent)
read(io::IO, c::NaturalChar{<:AbstractChar}) = read(io, c.parent)
write(io::IO, c::NaturalChar{<:AbstractChar}) = write(io, c.parent)
Char(c::NaturalChar{<:AbstractChar}) = Char(c.parent)


==(a::NaturalChar, b::NaturalChar) = (a.parent == b.parent)

# Even though "01" == "1", `isless` should provide a total ordering.

isless(a::NaturalChar{T}, b::NaturalChar{T}) where {T<:AbstractChar}
    a = a.parent
    b = b.parent
    isless(a,b) # TODO
end

isless(a::NaturalChar{<:AbstractChar}, b::NaturalChar{<:AbstractString}) = false
isless(a::NaturalChar{<:AbstractString}, b::NaturalChar{<:AbstractChar}) = true




struct NaturalString{T} <: AbstractString
    parent::T
end

ncodeunits(s::NaturalString) = ncodeunits(s.parent)
codeunit(s::NaturalString) = codeunit(s.parent)

# It is assumed that digits require exactly one code-unit. (This seems to be the case in all common encodings.)
function isvalid(s::NaturalString, i::Integer)
    @boundscheck 1 <= i <= ncodeunits(s) || return false
    i == 1 && return true
    isvalid(s.parent, i) || return false
    isdigit(s.parent[i]) || return true
    @inbounds isvalid(s.parent, i-1) || return true
    return !isdigit(@inbounds s.parent[i-1])
end

end # module
