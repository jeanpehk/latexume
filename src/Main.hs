module Main where

import System.Environment

import Resume
import Parser

import Text.Megaparsec

main :: IO ()
main = do
  args <- getArgs
  case args of
    (fn:_) -> compile fn
    []             -> putStrLn "Missing source file"

compile :: FilePath -> IO ()
compile fn = do
  prog <- readFile fn
  case parse parseResume fn prog of
    Left err  -> putStrLn $ errorBundlePretty err
    Right res -> do
                   writeFile "generated/latexume.tex" (genTex res)
                   putStrLn $ "Output at: \"generated/latexume.tex\""

test :: IO ()
test = do
  prog <- readFile "examples/example.md"
  case parse parseResume "example.md" prog of
    Left err -> putStrLn $ errorBundlePretty err
    Right x  -> putStrLn $ show x
