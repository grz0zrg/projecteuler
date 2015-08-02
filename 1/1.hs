 -- 1:1 conversion of 1.anubis to Haskell --

 -------------------------------------------
 --    by Julien Verneuil, 12/06/2015     --
 -------------------------------------------

 --       ghc 1.hs -o projecteuler_1      --

import System.Environment
import Debug.Trace
import Data.List
import Data.Maybe
import Text.Read

integer_sum :: Integer -> Integer
integer_sum n = (n * (n + 1)) `quot` 2

signed_lcm_list :: [Integer] -> [Integer]
signed_lcm_list l = 
    if null l then []
    else
        let h = head l
            t = tail l in
        if null t then [h]
        else
            let p = signed_lcm_list(t) in
            [h] ++ map (\x -> -(lcm h x)) p ++ p

print_ignore_message :: String -> a -> a
print_ignore_message s = trace("Parameter \"" ++ s ++ "\" ignored, not a natural number, you should fix this.\n")

to_integer :: String -> Maybe Integer
to_integer s = 
    case readMaybe s of
        Nothing ->
            print_ignore_message s
            Nothing
        Just n -> 
            if n <= 0 then
                print_ignore_message s
                Nothing
            else
                Just n

usage :: String
usage = "Usage:\n    projecteuler_1 max n1 n2 n3 ...\n\nExample:\n    projecteuler_1 999 3 5"

main = do
    args <- getArgs

    let args_as_int = mapMaybe ( to_integer ) args
        
    if null args_as_int then putStrLn usage
    else do
        let max         = head args_as_int 
            numbers     = tail args_as_int

        if null numbers then putStrLn usage
        else do
            let slcml       = signed_lcm_list(numbers)
                result      = sum(map (\x -> integer_sum(max `quot` abs(x)) * x) slcml)

            putStrLn("The sum of all the multiples of " ++ intercalate " or " (tail args) ++ " below " ++ show(max + 1) ++ " is " ++ show result ++ ".")
