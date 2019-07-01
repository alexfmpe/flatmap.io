{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RecordWildCards #-}

module Handler.Home where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Data.Either
import Import

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
-- Let's handle IOException and decodeFail
loadCompanies :: IO (Either String [Company])
loadCompanies = eitherDecode <$> B.readFile "config/companies.json"

getHomeR :: Handler Html
getHomeR =
  defaultLayout $ do
    App {..} <- getYesod
    aDomId <- newIdent
    setTitle "Welcome To Yesod!"
    ecompanies <- liftIO loadCompanies
    case ecompanies :: Either String [Company] of
      Left err -> do
        $logError $ pack err
        sendResponseStatus internalServerError500 err
      Right companies -> $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR =
  defaultLayout $ do
    App {..} <- getYesod
    companies <- liftIO $ fromRight [] <$> loadCompanies
    aDomId <- newIdent
    setTitle "Welcome To Yesod!"
    $(widgetFile "homepage")