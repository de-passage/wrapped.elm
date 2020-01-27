# Wrapped.elm

A mostly failed experiment with strong types in Elm

## Motivation

Strong types are a common pattern in languages with a strict type system to add semantics to types. It allows the programmer to gate some functions with the expectation that the input values satisfy some sort of requirements. 

The common approach in Elm is to define new custom types with a single constructor taking the underlying representation and to pattern match over it when needed, usually to interface with external/lower level functions. Unfortunately this can lead to a lot of boilerplate at module border when one need to convert back and forth between the strong type and its value. 

This module experiments with the idea of automating boilerplate generation of strong types while retaining the fine grained control over data access that hand-written types provide. 

## Design

The idea was to use a single polymorphic type, `Wrapped type access` with a phantom type describing the access policy on the contained value. The access parameter would be a record type containing a token type, private to a given module that would be used in the type unification process to allow or forbid the use of certain functions. The disabled functions could be accessed through a specialized version of the functions requiring a runtype representation of the token (ideally the token would be an empty type that would hopefully end up removed by the compiler)

## Result

Unfortunately, the result was only usable for very simple use cases where doing the work by hand was negligible. An unforseen consequence of the design was to hard to decipher error messages and a lot of boilerplate needed to get everything to work, defeating the purpose. The combinatorial nature of the problem of lifting functions also led to the need to have too many different versions of essentially the same function, which I never actually got around to implement.
