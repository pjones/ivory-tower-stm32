{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE TypeFamilies #-}

module Platforms where

import Ivory.Language
import Ivory.Tower
import Ivory.Tower.Frontend

import LEDTower
import Ivory.BSP.STM32F4.GPIO
import Ivory.BSP.STM32F4.RCC

data PX4FMUv17 = PX4FMUv17
data F4Discovery = F4Discovery
data Open407VC = Open407VC

class ColoredLEDs p where
  redLED  :: Proxy p -> LED
  blueLED :: Proxy p -> LED

instance ColoredLEDs PX4FMUv17 where
  redLED _  = LED pinB14 ActiveLow
  blueLED _ = LED pinB15 ActiveLow

f24MHz :: Uint32
f24MHz = 24000000
f8MHz :: Uint32
f8MHz = 8000000

-- XXX FIX SIGNALABLE CLASS DEFINITION
instance Signalable PX4FMUv17 where
  data SignalType PX4FMUv17 = PlaceholderSignalPX4FMUv17
    deriving (Eq, Read, Show)
  signals = [PlaceholderSignalPX4FMUv17]
  signalName = show
  signalFromName = read

instance BoardHSE PX4FMUv17 where
  hseFreq _ = f24MHz

-- XXX FIX SIGNALABLE CLASS DEFINITION
instance Signalable F4Discovery where
  data SignalType F4Discovery = PlaceholderSignalF4Discovery
    deriving (Eq, Read, Show)
  signals = [PlaceholderSignalF4Discovery]
  signalName = show
  signalFromName = read

instance ColoredLEDs F4Discovery where
  redLED _  = LED pinD14 ActiveHigh
  blueLED _ = LED pinD15 ActiveHigh

instance BoardHSE F4Discovery where
  hseFreq _ = f8MHz

-- XXX FIX SIGNALABLE CLASS DEFINITION
instance Signalable Open407VC where
  data SignalType Open407VC = PlaceholderSignalOpen407VC
    deriving (Eq, Read, Show)
  signals = [PlaceholderSignalOpen407VC]
  signalName = show
  signalFromName = read

instance ColoredLEDs Open407VC where
  redLED _  = LED pinD12 ActiveHigh
  blueLED _ = LED pinD13 ActiveHigh

instance BoardHSE Open407VC where
  hseFreq _ = f8MHz

coloredLEDPlatforms :: (forall p . (ColoredLEDs p, BoardHSE p) => Tower p ()) -> [(String, Twr)]
coloredLEDPlatforms app =
    [("px4fmu17_bare",     Twr (app :: Tower PX4FMUv17 ()))
    ,("px4fmu17_ioar",     Twr (app :: Tower PX4FMUv17 ()))
    ,("stm32f4discovery",  Twr (app :: Tower F4Discovery ()))
    ,("open407vc",         Twr (app :: Tower Open407VC ()))
    ]
