{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Web.Mastodon.Lib.Registration.Client
    ( startAuth
    , authBegun
    , authResults
    , authCodeToUserURL
    , authCodeToRedirectURL
    )
  where

import Data.Aeson
import qualified Data.Text as T

import Servant
import Servant.Client

import Web.Mastodon.Lib.Registration

startAuth :: ClientM AuthCode
authBegun :: AuthCode -> AppInfo -> ClientM ()
auth :: AuthCode -> ClientM ()
authComplete :: AuthCode -> Maybe T.Text -> ClientM AuthResult
authResults :: AuthCode -> ClientM OAuthCode

startAuth
  :<|> authBegun
  :<|> auth
  :<|> authComplete
  :<|> authResults
    = client lmrsAPI

authCodeToUserURL :: T.Text -> AuthCode -> T.Text
authCodeToUserURL server authCode =
        "https://" `T.append` server `T.append` "/auth/" `T.append` authCode

authCodeToRedirectURL :: T.Text -> AuthCode -> T.Text
authCodeToRedirectURL server authCode =
        "https://" `T.append` server `T.append` "/authcomplete/" `T.append` authCode
