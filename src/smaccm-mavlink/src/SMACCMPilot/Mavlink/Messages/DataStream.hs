{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.DataStream where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

dataStreamMsgId :: Uint8
dataStreamMsgId = 67

dataStreamCrcExtra :: Uint8
dataStreamCrcExtra = 21

dataStreamModule :: Module
dataStreamModule = package "mavlink_data_stream_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkDataStreamSender
  incl dataStreamUnpack
  defStruct (Proxy :: Proxy "data_stream_msg")

[ivory|
struct data_stream_msg
  { message_rate :: Stored Uint16
  ; stream_id :: Stored Uint8
  ; on_off :: Stored Uint8
  }
|]

mkDataStreamSender ::
  Def ('[ ConstRef s0 (Struct "data_stream_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 MavlinkArray -- tx buffer
        ] :-> ())
mkDataStreamSender =
  proc "mavlink_data_stream_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 4 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> message_rate)
  call_ pack buf 2 =<< deref (msg ~> stream_id)
  call_ pack buf 3 =<< deref (msg ~> on_off)
  -- 6: header len, 2: CRC len
  let usedLen = 6 + 4 + 2 :: Integer
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "dataStream payload is too large for 4 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    dataStreamMsgId
                    dataStreamCrcExtra
                    4
                    seqNum
                    sendArr
            let usedLenIx = fromInteger usedLen
            -- Zero out the unused portion of the array.
            for (fromInteger sendArrLen - usedLenIx) $ \ix ->
              store (sendArr ! (ix + usedLenIx)) 0
            retVoid

instance MavlinkUnpackableMsg "data_stream_msg" where
    unpackMsg = ( dataStreamUnpack , dataStreamMsgId )

dataStreamUnpack :: Def ('[ Ref s1 (Struct "data_stream_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
dataStreamUnpack = proc "mavlink_data_stream_unpack" $ \ msg buf -> body $ do
  store (msg ~> message_rate) =<< call unpack buf 0
  store (msg ~> stream_id) =<< call unpack buf 2
  store (msg ~> on_off) =<< call unpack buf 3

