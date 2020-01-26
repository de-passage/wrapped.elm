# Wrapped.elm

Generic strong type library for Elm

## Motivation

Strong types are a common pattern in languages with a strict type system to add semantics to types. It allows the programmer to gate some functions with the expectation that the input values satisfy some sort of requirements. 

The common approach in Elm is to define new custom types with a single constructor taking the underlying representation and to pattern match over it when needed, usually to interface with external/lower level functions. Unfortunately this can lead to a lot of boilerplate at module border when one need to convert back and forth between the strong type and its value. 

This module experiments with the idea of automating boilerplate generation of strong types while retaining the fine grained control over data access that hand-written types provide.
