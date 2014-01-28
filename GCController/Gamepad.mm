//
//  GamePad.cpp
//  HelloCpp
//
//  Created by giginet on 2014/1/19.
//
//

#include "ControllerElement.h"
#include "Gamepad.h"
#include "Controller.h"
#import <GameController/GameController.h>

namespace iOSGamePad {
    
    struct ControllerElement::GCControllerElementStruct {
        GCControllerElement *element;
    };
    
    struct Gamepad::GCGamepadStruct {
        GCGamepad *gamepad;
    };
    
    Gamepad::Gamepad()
    {
        _gamepadWrapper = std::shared_ptr<GCGamepadStruct>(new GCGamepadStruct());
    }

    Controller* Gamepad::getController()
    {
        return _controller;
    }
    
    void Gamepad::setValueChangedHandler(std::function<void (Gamepad *, ControllerElement *)> valueChangedHandler)
    {
        GCGamepad *gamepad = _gamepadWrapper->gamepad;
        if (valueChangedHandler) {
            gamepad.valueChangedHandler = ^(GCGamepad *pad, GCControllerElement *element) {
                // ToDo collection
                Gamepad* gamepad = new Gamepad();
                gamepad->_gamepadWrapper->gamepad = pad;
                ControllerElement* controllerElement = new ControllerElement();
                controllerElement->_elementWrapper->element = element;
                valueChangedHandler(gamepad, controllerElement);
            };
        } else {
            gamepad.valueChangedHandler = nil;
        }
    }
    
    ControllerButtonInput* Gamepad::getLeftSholder()
    {
        ControllerButtonInput* buttonInput = new ControllerButtonInput();
        buttonInput->_elementWrapper->element = [_gamepadWrapper->gamepad leftShoulder];
        return buttonInput;
    }
    
    ControllerButtonInput* Gamepad::getRightSholder()
    {
        ControllerButtonInput* buttonInput = new ControllerButtonInput();
        buttonInput->_elementWrapper->element = [_gamepadWrapper->gamepad rightShoulder];
        return buttonInput;
    }
    
    ControllerButtonInput* Gamepad::getButtonA()
    {
        ControllerButtonInput* buttonInput = new ControllerButtonInput();
        buttonInput->_elementWrapper->element = [_gamepadWrapper->gamepad buttonA];
        return buttonInput;
    }
    
    ControllerButtonInput* Gamepad::getButtonB()
    {
        ControllerButtonInput* buttonInput = new ControllerButtonInput();
        buttonInput->_elementWrapper->element = [_gamepadWrapper->gamepad buttonB];
        return buttonInput;
    }
    
    ControllerButtonInput* Gamepad::getButtonX()
    {
        ControllerButtonInput* buttonInput = new ControllerButtonInput();
        buttonInput->_elementWrapper->element = [_gamepadWrapper->gamepad buttonX];
        return buttonInput;
    }
    
    ControllerButtonInput* Gamepad::getButtonY()
    {
        ControllerButtonInput* buttonInput = new ControllerButtonInput();
        buttonInput->_elementWrapper->element = [_gamepadWrapper->gamepad buttonY];
        return buttonInput;
    }
    
    ControllerDirectionPad* Gamepad::getDpad()
    {
        ControllerDirectionPad* dpad = new ControllerDirectionPad();
        dpad->_elementWrapper->element = [_gamepadWrapper->gamepad dpad];
        return dpad;
    }

}