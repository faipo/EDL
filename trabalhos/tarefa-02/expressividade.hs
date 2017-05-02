module Main where

manipulartupla :: ([Char], Int) -> ([Char], Int)
manipulartupla (a,b)=(reverse(a),b+length a)

r=[("Rafael",250),("Joao",40),("Maria",79),("Camilo",126)]

main=print (map manipulartupla r)