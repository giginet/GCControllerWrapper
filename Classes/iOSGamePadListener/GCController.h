//
//  GCController.h
//  HelloCpp
//
//  Created by giginet on 2014/1/13.
//
//

#ifndef __HelloCpp__GCController__
#define __HelloCpp__GCController__

#include "cocos2d.h"
#include "EventButtonInput.h"

using namespace cocos2d;

namespace iOSGamePad {
    class Controller :public Object
    {
      public:
        
        struct GCControllerStruct;
        
        static Array *controllers();
        static void startWirelessControllerDiscoveryWithCompletionHandler(std::function<void (void)> completionHandler);
        static void stopWirelessControllerDiscovery();
        
        std::function<void (EventButtonInput *event)> getOnValueChangedHandler();
        void setOnValueChangedHandler(std::function<void (EventButtonInput *event) >handler);
        std::function<void (Controller *controller)> getControllerPausedHandler();
        void setControllerPausedHandler(std::function<void (Controller *controller) >handler);
        
        bool isAttachedToDevice();
        const char* getVendorName();
        int getPlayerIndex();
      
      private:
        Controller();
        
        std::function<void (EventButtonInput *event)> _onValueChangedHandler;
        std::function<void (Controller *controller) > _controllerPausedHandler;
        std::shared_ptr<GCControllerStruct> _controllerWrapper;
    };
}

#endif /* defined(__HelloCpp__GCController__) */
