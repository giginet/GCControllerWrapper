//
//  ControllerElement.h
//  GCControllerListenerDemo
//
//  Created by giginet on 2014/1/23.
//
//

#ifndef __GCControllerListenerDemo__ControllerElement__
#define __GCControllerListenerDemo__ControllerElement__

#include "Controller.h"

namespace iOSGamePad {
    class ControllerElement {
        
        struct GCControllerElementStruct;
        
    public:
        virtual bool isAnalog();
        
        virtual ControllerElement* getCollection() {
            return _collection;
        }
    
    private:
        ControllerElement();
        ControllerElement* _collection;
        std::shared_ptr<GCControllerElementStruct> _elementWrapper;
    };
    
    class ControllerAxisInput :public ControllerElement {
    public:
        bool isAnalog() override;
        ControllerElement* getCollection() override;
    };
    
    class ControllerButtonInput :public ControllerElement {
    public:
        ControllerElement* getCollection() override;
        bool isPressed();
        float getValue();
        void setValueChangedHandler(std::function< void (ControllerButtonInput* button, float value, bool pressed) > valueChangedHandler);
    private:
        std::function<void (ControllerButtonInput *button, float value, bool pressed)> _valueChangedHandler;
    };
    
    class ControllerDirectionPad :public ControllerElement {
    public:
        bool isAnalog() override;
        
        float getXAxis();
        float getYAxis();
        ControllerButtonInput* getUp();
        ControllerButtonInput* getDown();
        ControllerButtonInput* getLeft();
        ControllerButtonInput* getRight();
        
        void setValueChangedHandler(std::function<void (ControllerDirectionPad* dpad, float xValue, float yValue)> valueChangedHandler);
        
    private:
        std::function<void (ControllerDirectionPad* dpad, float xValue, float yValue)> _valueChangedHandler;
        
    };
    
}

#endif /* defined(__GCControllerListenerDemo__ControllerElement__) */
