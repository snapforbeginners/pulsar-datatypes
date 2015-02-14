{-# LANGUAGE OverloadedStrings #-}
module Odoo.Microblog
         (getAllMicroblogs
         ,getMicroblog
         ,insertMicroblog) where

import           Data.Maybe                    (listToMaybe)
import           GHC.Int                       (Int64)
import           Odoo.Types                    (Blog (..), Microblog (..),
                                                MicroblogID (..),
                                                ToPGMicroblog (..),
                                                Username (..))
import           Snap.Snaplet.PostgresqlSimple (HasPostgres (..), Only (..),
                                                execute, query, query_)


getAllMicroblogs :: (HasPostgres m) => m [Microblog]
getAllMicroblogs = query_ "SELECT * FROM microblogs"

getMicroblog
  :: (HasPostgres m)
  => MicroblogID
  -> m (Maybe Microblog)
getMicroblog (MicroblogID m_id) = do
  r <- query "SELECT * FROM microblogs WHERE id = ?" (Only m_id)
  return $ listToMaybe r

insertMicroblog :: (HasPostgres m)
                => ToPGMicroblog
                -> m Int64
insertMicroblog (ToPGMicroblog (Blog blog)  (Username user)) =
   execute "INSERT INTO \
           \microblogs (content, author)\
           \ VALUES (?, ?)" (blog, user)


