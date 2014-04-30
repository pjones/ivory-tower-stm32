{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}

module I2CTest where

import Ivory.Language
import Ivory.Tower

import Ivory.BSP.STM32F4.GPIO
import Ivory.BSP.STM32F4.RCC
import Ivory.BSP.STM32F4.Signalable

import Ivory.BSP.STM32F4.I2C

import Platforms

app ::  forall p . (ColoredLEDs p, BoardHSE p, STM32F4Signal p) => Tower p ()
app = do
  (req, res) <- i2cTower i2c1 pinB6 pinB7

  task "simplecontroller" $ do
    req_emitter <- withChannelEmitter req "req"
    res_event   <- withChannelEvent   res "res"
    periodic    <- withPeriodicEvent (Milliseconds 250)
    handleV periodic "periodic" $ \p -> do
      ifte_ ((p .% 500000) >=? 250000)
        (do r <- local $ istruct
                   -- Write values 0xF2, 0xF3, 0xEE to page 0
                   [ tx_addr   .= ival eepromaddr
                   , tx_buf    .= iarray [ival 0x00, ival 0xF2, ival 0xF3, ival 0xEE]
                   , tx_len    .= ival 4
                   , rx_len    .= ival 0
                   ]
            emit_ req_emitter (constRef r))
        (do r <- local $ istruct
                   [ tx_addr   .= ival eepromaddr
                   -- Read 3 values out of page 0 (should be 0xF2, 0xF3, 0xEE)
                   , tx_buf    .= iarray [ival 0x00]
                   , tx_len    .= ival 1
                   , rx_len    .= ival 3
                   ]
            emit_ req_emitter (constRef r))

    handle res_event "result" $ \_ -> return () -- XXX
  where
  -- Test against an AT24 EEPROM or equivalent
  eepromaddr = I2CDeviceAddr 0x50
