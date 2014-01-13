//
//  EventButtonInput.h
//  iOSGamePad
//
//  Created by giginet on 2014/1/13.
//
//

#ifndef __iOSGamePad__ButtonInputEvent__
#define __iOSGamePad__ButtonInputEvent__

#include "cocos2d.h"

using namespace cocos2d;

namespace iOSGamePad {
    class EventButtonInput
    {
    public:
        
        enum class ButtonCode
        {
            BUTTON_A,
            BUTTON_B,
            BUTTON_X,
            BUTTON_Y,
            BUTTON_LEFT_SHOLDER,
            BUTTON_RIGHT_SHOLDER,
            BUTTON_DPAD_UP,
            BUTTON_DPAD_RIGHT,
            BUTTON_DPAD_LEFT,
            BUTTON_DPAD_DOWN
        };
        
        EventButtonInput(ButtonCode buttonCode, bool isPressed, float value);
        
        bool isPressed();
        float getValue();
        
    private:
        bool _pressed;
        float _value;
    };
}

#endif /* defined(__iOSGamePad__ButtonInputEvent__) */
