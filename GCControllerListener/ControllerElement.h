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
        
    public:
        struct GCControllerElementStruct;
        virtual bool isAnalog();
        
        virtual ControllerElement* getCollection() {
            return _collection;
        }
    
    protected:
        ControllerElement();
        ControllerElement* _collection;
        std::shared_ptr<GCControllerElementStruct> _elementWrapper;
    };
    
    class ControllerAxisInput :public ControllerElement {
    public:
        float getValue();
        void setValueChangedHandler(std::function<void (ControllerAxisInput *axis, float value)> valueChangedHandler);
        friend class ControllerDirectionPad;
    private:
        std::function<void (ControllerAxisInput *axis, float value)> _valueChangedHandler;
    };
    
    class ControllerButtonInput :public ControllerElement {
    public:
        bool isPressed();
        float getValue();
        void setValueChangedHandler(std::function< void (ControllerButtonInput* button, float value, bool pressed) > valueChangedHandler);
        friend class ControllerDirectionPad;
    private:
        std::function<void (ControllerButtonInput *button, float value, bool pressed)> _valueChangedHandler;
    };
    
    class ControllerDirectionPad :public ControllerElement {
    public:
        ControllerAxisInput* getXAxis();
        ControllerAxisInput* getYAxis();
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
