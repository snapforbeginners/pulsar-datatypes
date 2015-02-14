{-# LANGUAGE OverloadedStrings #-}
module Odoo.Handlers where

import qualified Data.Text                     as T (pack)
import           Odoo.Microblog                (getAllMicroblogs, getMicroblog,
                                                insertMicroblog)
import           Odoo.Types                    (Blog (..), MicroblogID (..),
                                                ToPGMicroblog (..),
                                                Username (..))
import           Snap                          (Handler, writeText)
import           Snap.Snaplet.PostgresqlSimple (Postgres)

microblog :: ToPGMicroblog
microblog = ToPGMicroblog (Blog "My awesome microblog!") (Username "biscarch")

insertTest :: Handler b Postgres ()
insertTest = do
           rowsAffected <- insertMicroblog microblog
           writeText $ T.pack $ show rowsAffected

getAllTest :: Handler b Postgres ()
getAllTest = do
           mblogs <- getAllMicroblogs
           writeText $ T.pack $ show mblogs

getOneTest :: Handler b Postgres ()
getOneTest = do
           mblog <- getMicroblog (MicroblogID 1)
           case mblog of
             Nothing -> writeText "No Blog"
             Just b -> writeText $ T.pack $ show b
