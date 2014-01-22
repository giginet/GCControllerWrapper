//
//  EventListenerGamePad.h
//  iOSGamePad
//
//  Created by giginet on 2014/1/13.
//
//

#ifndef __iOSGamePad__EventListenerGamePad__
#define __iOSGamePad__EventListenerGamePad__

#include "cocos2d.h"

using namespace cocos2d;

namespace iOSGamePad {
    
    class EventButtonInput;
    
    class EventListenerGamePad : public EventListenerCustom
    {
    public:
        static EventListenerCustom* create(const std::string& eventName, std::function<void(EventCustom*)> callback);
        
        /// Overrides
        virtual bool checkAvaiable() override;
        virtual EventListenerCustom* clone() override;
        
    protected:
        /** Constructor */
        EventListenerGamePad();
        
        /** Initializes event with type and callback function */
        bool init(const std::string& eventName, std::function<void(EventButtonInput*)> callback);
        
        std::function<void(EventCustom*)> _onCustomEvent;
    };

    
}

#endif /* defined(__iOSGamePad__EventListenerGamePad__) */
