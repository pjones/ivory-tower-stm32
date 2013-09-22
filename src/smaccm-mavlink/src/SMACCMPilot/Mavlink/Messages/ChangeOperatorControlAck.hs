{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.ChangeOperatorControlAck where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

changeOperatorControlAckMsgId :: Uint8
changeOperatorControlAckMsgId = 6

changeOperatorControlAckCrcExtra :: Uint8
changeOperatorControlAckCrcExtra = 104

changeOperatorControlAckModule :: Module
changeOperatorControlAckModule = package "mavlink_change_operator_control_ack_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkChangeOperatorControlAckSender
  incl changeOperatorControlAckUnpack
  defStruct (Proxy :: Proxy "change_operator_control_ack_msg")

[ivory|
struct change_operator_control_ack_msg
  { gcs_system_id :: Stored Uint8
  ; control_request :: Stored Uint8
  ; ack :: Stored Uint8
  }
|]

mkChangeOperatorControlAckSender ::
  Def ('[ ConstRef s0 (Struct "change_operator_control_ack_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 MavlinkArray -- tx buffer
        ] :-> ())
mkChangeOperatorControlAckSender =
  proc "mavlink_change_operator_control_ack_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 3 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> gcs_system_id)
  call_ pack buf 1 =<< deref (msg ~> control_request)
  call_ pack buf 2 =<< deref (msg ~> ack)
  -- 6: header len, 2: CRC len
  let usedLen = 6 + 3 + 2 :: Integer
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "changeOperatorControlAck payload is too large for 3 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    changeOperatorControlAckMsgId
                    changeOperatorControlAckCrcExtra
                    3
                    seqNum
                    sendArr
            let usedLenIx = fromInteger usedLen
            -- Zero out the unused portion of the array.
            for (fromInteger sendArrLen - usedLenIx) $ \ix ->
              store (sendArr ! (ix + usedLenIx)) 0
            retVoid

instance MavlinkUnpackableMsg "change_operator_control_ack_msg" where
    unpackMsg = ( changeOperatorControlAckUnpack , changeOperatorControlAckMsgId )

changeOperatorControlAckUnpack :: Def ('[ Ref s1 (Struct "change_operator_control_ack_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
changeOperatorControlAckUnpack = proc "mavlink_change_operator_control_ack_unpack" $ \ msg buf -> body $ do
  store (msg ~> gcs_system_id) =<< call unpack buf 0
  store (msg ~> control_request) =<< call unpack buf 1
  store (msg ~> ack) =<< call unpack buf 2

