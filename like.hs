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
like _  "*" = True
like (sc:s) (pc:p) =
    case pc of
        '?' -> like s p
        '*' -> h (sc:s) p
               where h = \s2 p2 -> not (null s2) && (like s2 p2 || h (tail s2) p2)
        '#' -> (isDigit sc) && like s p
        _   -> sc == pc && like s p

main :: IO ()
main = do
    args <- getArgs
    putStrLn $ if (args !! 0) `like` (args !! 1) then "true" else "false"
