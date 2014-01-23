//
//  ControllerElement.cpp
//  GCControllerListenerDemo
//
//  Created by giginet on 2014/1/23.
//
//

#include "ControllerElement.h"
#include <GameController/GameController.h>

namespace iOSGamePad {
    
    struct ControllerElement::GCControllerElementStruct {
        GCControllerElement *element;
    };
    
    ControllerElement::ControllerElement() {
        _elementWrapper = std::shared_ptr<GCControllerElementStruct>(new GCControllerElementStruct());
        _collection = NULL;
    }
    
    bool ControllerElement::isAnalog() {
        return [_elementWrapper->element isAnalog];
    }
    
    float ControllerAxisInput::getValue() {
        return [(GCControllerAxisInput *)(_elementWrapper->element) value];
    }
    
    void ControllerAxisInput::setValueChangedHandler(std::function<void (ControllerAxisInput *, float)> valueChangedHandler) {
        GCControllerAxisInput *controllerAxisInput = (GCControllerAxisInput *)(_elementWrapper->element);
        if (valueChangedHandler) {
            controllerAxisInput.valueChangedHandler = ^(GCControllerAxisInput *axis, float value) {
                ControllerAxisInput *axisInput = new ControllerAxisInput();
                // ToDo collection passes
                axisInput->_elementWrapper->element = axis;
                valueChangedHandler(axisInput, value);
            };
        } else {
            controllerAxisInput.valueChangedHandler = nil;
        }
    }
    
    bool ControllerButtonInput::isPressed() {
        return [(GCControllerButtonInput *)(_elementWrapper->element) isPressed];
    }
    
    float ControllerButtonInput::getValue() {
        return [(GCControllerButtonInput *)(_elementWrapper->element) value];
    }
    
    void ControllerButtonInput::setValueChangedHandler(std::function<void (ControllerButtonInput *, float, bool)> valueChangedHandler) {
        GCControllerButtonInput *controllerButtonInput = (GCControllerButtonInput *)(_elementWrapper->element);
        if (valueChangedHandler) {
            controllerButtonInput.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
                ControllerButtonInput *buttonInput = new ControllerButtonInput();
                buttonInput->_elementWrapper->element = button;
                valueChangedHandler(buttonInput, value, pressed);
                
            };
        } else {
            controllerButtonInput.valueChangedHandler = nil;
        }
    }
    
    ControllerAxisInput* ControllerDirectionPad::getXAxis() {
        ControllerAxisInput *axisInput = new ControllerAxisInput();
        axisInput->_collection = this;
        axisInput->_elementWrapper->element = [(GCControllerDirectionPad *)(_elementWrapper->element) xAxis];
        return axisInput;
    }
    
    ControllerAxisInput* ControllerDirectionPad::getYAxis() {
        ControllerAxisInput *axisInput = new ControllerAxisInput();
        axisInput->_collection = this;
        axisInput->_elementWrapper->element = [(GCControllerDirectionPad *)(_elementWrapper->element) yAxis];
        return axisInput;
    }
    
    ControllerButtonInput* ControllerDirectionPad::getUp() {
        ControllerButtonInput *buttonInput = new ControllerButtonInput();
        buttonInput->_collection = this;
        buttonInput->_elementWrapper->element = [(GCControllerDirectionPad *)(_elementWrapper->element) up];
        return buttonInput;
    }
    
    ControllerButtonInput* ControllerDirectionPad::getDown() {
        ControllerButtonInput *buttonInput = new ControllerButtonInput();
        buttonInput->_collection = this;
        buttonInput->_elementWrapper->element = [(GCControllerDirectionPad *)(_elementWrapper->element) down];
        return buttonInput;
    }
    
    ControllerButtonInput* ControllerDirectionPad::getLeft() {
        ControllerButtonInput *buttonInput = new ControllerButtonInput();
        buttonInput->_collection = this;
        buttonInput->_elementWrapper->element = [(GCControllerDirectionPad *)(_elementWrapper->element) left];
        return buttonInput;
    }
    
    ControllerButtonInput* ControllerDirectionPad::getRight() {
        ControllerButtonInput *buttonInput = new ControllerButtonInput();
        buttonInput->_collection = this;
        buttonInput->_elementWrapper->element = [(GCControllerDirectionPad *)(_elementWrapper->element) right];
        return buttonInput;
    }
    
    void ControllerDirectionPad::setValueChangedHandler(std::function<void (ControllerDirectionPad *, float, float)> valueChangedHandler) {
        GCControllerDirectionPad *controllerDirectionPad = (GCControllerDirectionPad *)(_elementWrapper->element);
        if (valueChangedHandler) {
            controllerDirectionPad.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue) {
                ControllerDirectionPad *directionPad = new ControllerDirectionPad();
                directionPad->_elementWrapper->element = dpad;
                valueChangedHandler(directionPad, xValue, yValue);
                
            };
        } else {
            controllerDirectionPad.valueChangedHandler = nil;
        }
    }
    
}