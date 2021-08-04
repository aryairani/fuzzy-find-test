module Lib
    ( someFunc
    ) where

import Text.FuzzyFind
import Data.Foldable
import Data.List
import System.Environment

someFunc :: IO ()
someFunc = do
    queryArgs <- getArgs
    -- discard everything but the first field
    stdinLines <- fmap (takeWhile (/= ',')) . lines <$> getContents
    traverse_ (putStrLn . show) $ sort (fuzzyFind queryArgs stdinLines)