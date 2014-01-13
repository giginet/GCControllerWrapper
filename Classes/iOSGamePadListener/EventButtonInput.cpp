//
//  EventButtonInput.cpp
//  iOSGamePadListener
//
//  Created by giginet on 2014/1/13.
//
//

#include "EventButtonInput.h"

namespace iOSGamePad {
    
    EventButtonInput::EventButtonInput(ButtonCode buttonCode, bool isPressed, float value)
    {
        _pressed = isPressed;
        _value = value;
    }
    
}
