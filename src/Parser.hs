module Parser where

import Resume

import Data.Char
import Data.Void
import Data.Functor (void)
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L

type Parser = Parsec Void String
type Name = String
type Email = String
type Opt = String

-- | Helpers for parsing.

skip :: Parser ()
skip = L.space space1 empty empty

lexeme :: Parser a -> Parser a
lexeme = L.lexeme skip

symbol :: String -> Parser String
symbol = L.symbol skip

num :: Parser Int
num = lexeme L.decimal

-- | Parse a resume.
parseResume :: Name -> [Opt] -> Parser Resume
parseResume name opts = do
  s <- many parseSection
  return $ Resume name opts s

-- | Parse a section.
parseSection :: Parser Section
parseSection = do
  symbol "#"
  header <- lexeme $ many (anySingleBut '\n')
  ss <- many parseSubSection
  return $ Section header ss

-- | Parse a subsection.
parseSubSection :: Parser SubSection
parseSubSection = do
  symbol "##"
  header <- many (anySingleBut '|')
  symbol "|"
  from <- time
  symbol "-"
  to <- optional time
  text <- parseText
  return $ SubSection header from to text

parseText :: Parser [LXString]
parseText = many parseSingleText

parseSingleText :: Parser LXString
parseSingleText = Normal <$> some (noneOf "#*")
  <|> Bold <$> parseBold
  <|> Italic <$> parseItalic

parseBold :: Parser String
parseBold = symbol "**" *> some alphaNumChar <* symbol "**"

parseItalic :: Parser String
parseItalic = symbol "*" *> some alphaNumChar <* symbol "*"

-- | Parse time.
time :: Parser Time
time = do
  m <- num
  symbol "/"
  y <- num
  return $ Time m y

