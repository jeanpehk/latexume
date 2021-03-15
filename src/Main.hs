module Main where

import System.Environment

import Resume
import Parser

import Text.Megaparsec

main :: IO ()
main = do
  args <- getArgs
  case args of
    (fn:name:opts) -> compile fn name opts
    (fn:[])        -> putStrLn "Missing name"
    []             -> putStrLn "Missing source file and name"

compile :: FilePath -> String -> [String] -> IO ()
compile fn name opts = do
  prog <- readFile fn
  case parse (parseResume name opts) fn prog of
    Left err  -> putStrLn $ errorBundlePretty err
    Right res -> do
                   writeFile "generated/latexume.tex" (genTex res)
                   putStrLn $ "Output at: \"generated/latexume.tex\""

test :: IO ()
test = do
  prog <- readFile "examples/example.md"
  let resume = parseResume "Test Name" ["me@mail.com", "github.com/usir"]
  case parse resume "example.md" prog of
    Left err -> putStrLn $ errorBundlePretty err
    Right x  -> putStrLn $ show x
