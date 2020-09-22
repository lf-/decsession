{-# LANGUAGE OverloadedStrings #-}
module Main where
import Web.ClientSession
import System.Environment
import qualified Data.ByteString.Base64 as B64
import qualified Data.ByteString as BS
import Yesod.Core.Types (SessionCookie)
import Data.Word
import Data.Serialize

isSpace :: Word8 -> Bool
isSpace w = w == 32 || w - 9 <= 4

main :: IO ()
main = do
    arg:args <- getArgs
    key <- getKey arg
    cookie <- BS.filter (not . isSpace) <$> BS.getContents
    -- \n
    -- BS.putStr cookie
    dec <- maybe (fail "failed to decrypt cookie") pure $ decrypt key cookie
    dec' <- either fail pure $ decode dec :: IO SessionCookie
    putStrLn $ show dec'
    return ()
