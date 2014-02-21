{-#LANGUAGE ScopedTypeVariables,RankNTypes #-}
module Common where

import Data.List
import BasicMath



type M_raw_tri=([R3],[I3])


prettyPrintRaw ((vs,ts)::M_raw_tri) = "(\n"++pp vs ++ ",\n" ++ pp ts++"\n)"
	where 
	pp (ss::(Show a)=>a) = "\t[\n"++intercalate ",\n" ["\t\t"++show s|s<-ss]++"\n\t]"
parseWavefront (s::String) = (f $ (map words) $ lines s)::M_raw_tri where
	f [] = ([],[])
	f (l:ls) = case l of
		["v",x,y,z]	-> ((r x,r y,r z):vs,ts)
		("f":ws)	-> (vs,g (map ((`减` (1::Int)) . (read::String->Int).takeWhile (/='/')) ws::[I])++ts)
		_ 			-> (vs,ts)
		where
		r = read
		(vs,ts) = f ls
		g (i:a:b:is) = (i,a,b):g (i:b:is)
		g [_,_] = []
printWavefront ((vs,ts)::M_raw_tri) = concat (map (f "v") vs++["\n"]++map (f "f". \(x,y,z)->(x+1,y+1,z+1)) ts)::String
	where 
	f::(Show a)=>String->(a,a,a)->String
	f s (x,y,z) = s++" "++intercalate " "(map show [x,y,z])++"\n"


