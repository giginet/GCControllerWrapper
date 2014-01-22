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
    
    struct iOSGamePad::ControllerElement::GCControllerElementStruct {
        GCControllerElement *element;
    };
    
    iOSGamePad::ControllerElement::ControllerElement() {
        _elementWrapper = std::shared_ptr<GCControllerElementStruct>(new GCControllerElementStruct());
        _collection = NULL;
    }
    
    bool iOSGamePad::ControllerElement::isAnalog() {
        return [_elementWrapper->element isAnalog];
    }

    
}