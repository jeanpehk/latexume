module Resume where

-- | A Haskell representation of the resume.

----------------------------------------------------------------
-- Datatypes
----------------------------------------------------------------

data Resume = Resume
  { name :: String
  , opts :: [String]
  , sections :: [Section] }
  deriving Show

data Section = Section
  { header :: String
  , subs :: [SubSection] }
  deriving Show

data SubSection = SubSection
  { subheader :: String
  , from :: Time
  , to :: Maybe Time
  , content :: [LXString] }
  deriving Show

data LXString
  = Normal String
  | Italic String
  | Bold String
  deriving Show

data Time = Time
  { month :: Int
  , year :: Int }
  deriving Show

----------------------------------------------------------------
-- Resume Tex generation
----------------------------------------------------------------

genTex :: Resume -> String
genTex (Resume name opts sections) =
  start name opts
  ++ concat (map genSection sections)
  ++ end

genSection :: Section -> String
genSection (Section header subsections) =
  "\\section{" ++ header ++ "}"
  ++ "\n\n"
  ++ concat (map genSubSection subsections)

genSubSection :: SubSection -> String
genSubSection (SubSection header from to content) =
  "\\subsec{" ++ header ++ "}"
  ++ "{" ++ genTime from
  ++ "--"
  ++ maybeTimeStr to ++ "}"
  ++ "\n\n"
  ++ concat (map lxToTex content)

genTime :: Time -> String
genTime (Time month year) =
  show month ++ "/" ++ show year

----------------------------------------------------------------
-- Helpers
----------------------------------------------------------------

-- A base start for the documents.
-- Takes a name and a list of optional info.
start :: String -> [String] -> String
start name opts =
  "\\documentclass[paper=a4, fontsize=11pt]{resume}" ++ "\n\n"
   ++ "\\begin{document}\n\n"
   ++ "\\name{" ++ name ++ "}\n\n"
   ++ "\\contact"
   ++ concat (map (\y -> "{" ++ y ++ "}") opts)
   ++ "\n\n"

-- Ending of the document.
end :: String
end = "\\end{document}"

lxToTex :: LXString -> String
lxToTex (Normal s) = s
lxToTex (Italic s) = "\\emph{" ++ s ++ "}"
lxToTex (Bold s)   = "\\textbf{" ++ s ++ "}"

maybeTimeStr :: Maybe Time -> String
maybeTimeStr mt = case mt of
  Nothing -> ""
  Just t -> genTime t

