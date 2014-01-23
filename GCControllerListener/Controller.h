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

namespace iOSGamePad {
    
    class Gamepad;
    
    class Controller
    {
      public:
        
        struct GCControllerStruct;
        
        static std::vector<Controller *> controllers();
        static void startWirelessControllerDiscoveryWithCompletionHandler(std::function<void (void)> completionHandler);
        static void stopWirelessControllerDiscovery();
        
        static void setControllerDidConnected(std::function<void (void)> handler);
        static void setControllerDidDisconnected(std::function<void (void)> handler);
        
        void setControllerPausedHandler(std::function<void (Controller *controller) >handler);
        
        bool isAttachedToDevice();
        const char* getVendorName();
        int getPlayerIndex();
        
        Gamepad* getGamepad();
      
      private:
        Controller();
        
        std::function<void (Controller *controller) > _controllerPausedHandler;
        std::shared_ptr<GCControllerStruct> _controllerWrapper;
    };
}

#endif /* defined(__HelloCpp__GCController__) */
