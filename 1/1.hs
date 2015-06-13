 -- Translation of 1.anubis in Haskell --

 ----------------------------------------
 --   by Julien Verneuil, 12/06/2015   --
 ----------------------------------------

import System.Environment
import Data.List

integer_sum n = (n * (n + 1)) `quot` 2

signed_lcm_list l = 
    if null l then []
    else do
        let h = head l
            t = tail l
        if null t then [h]
        else do
            let p = signed_lcm_list(t)
            [h] ++ map (\x -> -(lcm h x)) p ++ p

main = do
    args <- getArgs

    let args_as_int = map (read :: String->Integer) args 
        max         = head args_as_int 
        numbers     = tail args_as_int
        slcml       = signed_lcm_list(numbers)
        result      = sum(map (\x -> integer_sum(max `quot` abs(x)) * x) slcml)

    print("The sum of all the multiples of " ++ intercalate " or " (tail args) ++ " below " ++ show(max + 1) ++ " is " ++ show result)
