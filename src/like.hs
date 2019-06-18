import Data.Char (isDigit)
import System.Environment

{-
 -  Visual Basic's Like operator in Haskell.
 -
 -  ? matches exactly one character
 -  * matches zero or more characters
 -  # matches exactly one digit
 -
 -  @author Urs Schmidt
 -}
like :: String -> String -> Bool
like [] p   = all (== '*') p
like _  []  = False
like (sc:s) (pc:p) =
    if all (== '*') (pc:p) then True
    else case pc of
        '?' -> like s p
        '*' -> h (sc:s) p
               where h = \t q -> not (null t) && (like t q || h (tail t) q)
        '#' -> (isDigit sc) && like s p
        _   -> sc == pc && like s p

main :: IO ()
main = do
    args <- getArgs
    putStrLn $ if (args !! 0) `like` (args !! 1) then "true" else "false"
