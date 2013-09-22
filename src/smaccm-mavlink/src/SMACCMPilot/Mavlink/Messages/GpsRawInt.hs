{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.GpsRawInt where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

gpsRawIntMsgId :: Uint8
gpsRawIntMsgId = 24

gpsRawIntCrcExtra :: Uint8
gpsRawIntCrcExtra = 24

gpsRawIntModule :: Module
gpsRawIntModule = package "mavlink_gps_raw_int_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkGpsRawIntSender
  incl gpsRawIntUnpack
  defStruct (Proxy :: Proxy "gps_raw_int_msg")

[ivory|
struct gps_raw_int_msg
  { time_usec :: Stored Uint64
  ; lat :: Stored Sint32
  ; lon :: Stored Sint32
  ; alt :: Stored Sint32
  ; eph :: Stored Uint16
  ; epv :: Stored Uint16
  ; vel :: Stored Uint16
  ; cog :: Stored Uint16
  ; fix_type :: Stored Uint8
  ; satellites_visible :: Stored Uint8
  }
|]

mkGpsRawIntSender ::
  Def ('[ ConstRef s0 (Struct "gps_raw_int_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 MavlinkArray -- tx buffer
        ] :-> ())
mkGpsRawIntSender =
  proc "mavlink_gps_raw_int_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 30 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> time_usec)
  call_ pack buf 8 =<< deref (msg ~> lat)
  call_ pack buf 12 =<< deref (msg ~> lon)
  call_ pack buf 16 =<< deref (msg ~> alt)
  call_ pack buf 20 =<< deref (msg ~> eph)
  call_ pack buf 22 =<< deref (msg ~> epv)
  call_ pack buf 24 =<< deref (msg ~> vel)
  call_ pack buf 26 =<< deref (msg ~> cog)
  call_ pack buf 28 =<< deref (msg ~> fix_type)
  call_ pack buf 29 =<< deref (msg ~> satellites_visible)
  -- 6: header len, 2: CRC len
  let usedLen = 6 + 30 + 2 :: Integer
  let sendArrLen = arrayLen sendArr
  if sendArrLen < usedLen
    then error "gpsRawInt payload is too large for 30 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    gpsRawIntMsgId
                    gpsRawIntCrcExtra
                    30
                    seqNum
                    sendArr
            let usedLenIx = fromInteger usedLen
            -- Zero out the unused portion of the array.
            for (fromInteger sendArrLen - usedLenIx) $ \ix ->
              store (sendArr ! (ix + usedLenIx)) 0
            retVoid

instance MavlinkUnpackableMsg "gps_raw_int_msg" where
    unpackMsg = ( gpsRawIntUnpack , gpsRawIntMsgId )

gpsRawIntUnpack :: Def ('[ Ref s1 (Struct "gps_raw_int_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
gpsRawIntUnpack = proc "mavlink_gps_raw_int_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_usec) =<< call unpack buf 0
  store (msg ~> lat) =<< call unpack buf 8
  store (msg ~> lon) =<< call unpack buf 12
  store (msg ~> alt) =<< call unpack buf 16
  store (msg ~> eph) =<< call unpack buf 20
  store (msg ~> epv) =<< call unpack buf 22
  store (msg ~> vel) =<< call unpack buf 24
  store (msg ~> cog) =<< call unpack buf 26
  store (msg ~> fix_type) =<< call unpack buf 28
  store (msg ~> satellites_visible) =<< call unpack buf 29

