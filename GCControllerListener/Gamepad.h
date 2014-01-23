//
//  GamePad.h
//  HelloCpp
//
//  Created by giginet on 2014/1/19.
//
//

#ifndef __HelloCpp__GamePad__
#define __HelloCpp__GamePad__

#include "ControllerElement.h"

namespace iOSGamePad {
    
    class Controller;
    class ControllerElement;
    class ControllerButtonInput;
    class ControllerDirectionPad;
    
    class Gamepad
    {
    public:
        struct GCGamepadStruct;
        Controller *getController();
        void setValueChangedHandler(std::function<void (Gamepad *gamePad, ControllerElement *element)> valueChangedHandler);
        
        ControllerButtonInput* getLeftSholder();
        ControllerButtonInput* getRightSholder();
        
        ControllerButtonInput* getButtonA();
        ControllerButtonInput* getButtonB();
        ControllerButtonInput* getButtonX();
        ControllerButtonInput* getButtonY();
        
        ControllerDirectionPad* getDpad();
    private:
        Gamepad();
        Controller* _controller;
        GCGamepadStruct* _gamepadWrapper;
        std::function<void (Gamepad *gamePad, ControllerElement *element)> _valueChangedHandler;
        friend class Controller;
    };
}

#endif /* defined(__HelloCpp__GamePad__) */
