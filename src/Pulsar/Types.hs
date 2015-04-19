{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Pulsar.Types
              (Microblog(..)
              ,ToPGMicroblog(..)
              ,Blog (..)
              ,Username (..)
              ,MicroblogID(..)) where

import           Control.Applicative                  ((<$>), (<*>))
import           Data.Text                            (Text)
import           Data.Time.Clock                      (UTCTime)
import           Database.PostgreSQL.Simple.FromField (FromField (..))
import           Snap.Snaplet.PostgresqlSimple        (FromRow (..), field)

data Microblog = Microblog { mid        :: MicroblogID
                           , content    :: Blog
                           , author     :: Username
                           , created_at :: UTCTime } deriving (Show)

newtype MicroblogID = MicroblogID Int deriving (Show, FromField)
newtype Username = Username Text deriving (Show, FromField)
newtype Blog = Blog Text deriving (Show, FromField)

data ToPGMicroblog = ToPGMicroblog Blog Username

instance FromRow Microblog where
  fromRow = Microblog
            <$> field
            <*> field
            <*> field
            <*> field

