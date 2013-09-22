{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.NamedValueInt where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

namedValueIntMsgId :: Uint8
namedValueIntMsgId = 252

namedValueIntCrcExtra :: Uint8
namedValueIntCrcExtra = 44

namedValueIntModule :: Module
namedValueIntModule = package "mavlink_named_value_int_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkNamedValueIntSender
  incl namedValueIntUnpack
  defStruct (Proxy :: Proxy "named_value_int_msg")

[ivory|
struct named_value_int_msg
  { time_boot_ms :: Stored Uint32
  ; value :: Stored Sint32
  ; name :: Array 10 (Stored Uint8)
  }
|]

mkNamedValueIntSender ::
  Def ('[ ConstRef s0 (Struct "named_value_int_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 MavlinkArray -- tx buffer
        ] :-> ())
mkNamedValueIntSender =
  proc "mavlink_named_value_int_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 18 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> time_boot_ms)
  call_ pack buf 4 =<< deref (msg ~> value)
  arrayPack buf 8 (msg ~> name)
  -- 6: header len, 2: CRC len
  let usedLen = 6 + 18 + 2 :: Integer
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "namedValueInt payload is too large for 18 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    namedValueIntMsgId
                    namedValueIntCrcExtra
                    18
                    seqNum
                    sendArr
            let usedLenIx = fromInteger usedLen
            -- Zero out the unused portion of the array.
            for (fromInteger sendArrLen - usedLenIx) $ \ix ->
              store (sendArr ! (ix + usedLenIx)) 0
            retVoid

instance MavlinkUnpackableMsg "named_value_int_msg" where
    unpackMsg = ( namedValueIntUnpack , namedValueIntMsgId )

namedValueIntUnpack :: Def ('[ Ref s1 (Struct "named_value_int_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
namedValueIntUnpack = proc "mavlink_named_value_int_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_boot_ms) =<< call unpack buf 0
  store (msg ~> value) =<< call unpack buf 4
  arrayUnpack buf 8 (msg ~> name)

