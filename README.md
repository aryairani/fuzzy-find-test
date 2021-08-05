# fuzzy-find-test

Here is a little program for testing the performance of the fuzzyfind haskell lib.

The main logic is in https://github.com/aryairani/fuzzy-find-test/blob/main/src/Lib.hs

```haskell
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
```

The input I used is in https://gist.github.com/aryairani/34d4b6cf65a7cb6117880c65d642a587

I compiled with `-O2`.

The command-line I used is: 
```bash
stack exec -- time fuzzy-find-test-exe "M.tL" < shared.namespace.csv
```
which produced the top match **`contrib.bascott.continuations.v1._external.base.M1l.Map.toList`** in 2.5–3 seconds, as compared to 
```bash
time fzf -n 1 -d, -q M.tL < shared.namespace.csv
```
which returned the top match **`base.Map.toList`** in 0.01–0.02 seconds

How can we improve it?
