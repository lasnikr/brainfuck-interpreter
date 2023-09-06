module Main where

import Language.Brainfuck
import Control.Monad (when)

import Data.Array hiding (array)
import System.Posix.Resource
    ( setResourceLimit,
      Resource(ResourceCPUTime),
      ResourceLimit(ResourceLimit),
      ResourceLimits(ResourceLimits) )

main :: IO ()
main = do
  setResourceLimit ResourceCPUTime $ ResourceLimits (ResourceLimit 5) (ResourceLimit 5)
  run

run = do
  putStrLn "Program:"
  prog <- getLine
  c    <- core
  let cmds = loadProgram prog
  when debug $ print cmds
  execute cmds (snd (bounds cmds)) (BF c 0 0)
