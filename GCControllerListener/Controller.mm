//
//  GCController.cpp
//  HelloCpp
//
//  Created by giginet on 2014/1/13.
//
//

#include "Controller.h"
#include "Gamepad.h"
#import <GameController/GameController.h>

namespace iOSGamePad {
    
    std::shared_ptr< std::vector<Controller *> > Controller::_controllers = NULL;
    
    struct Controller::GCControllerStruct {
        GCController *controller;
    };
    
    struct Gamepad::GCGamepadStruct {
        GCGamepad *gamepad;
    };
    
    Controller::Controller()
    {
        _controllers = NULL;
        _controllerWrapper = std::shared_ptr<GCControllerStruct>(new GCControllerStruct());
    }
    
    std::vector<Controller *>* Controller::controllers()
    {
        if (_controllers == NULL || _controllers->size() == 0) {
            NSArray *controllers = [GCController controllers];
            _controllers = std::shared_ptr< std::vector<Controller *> >(new std::vector<Controller *>());
            for (int i = 0; i < [controllers count]; ++i) {
                auto controller = new Controller();
                controller->_controllerWrapper->controller = controllers[i];
                _controllers->push_back(controller);
            }
        }
        return _controllers.get();
    }
    
    void Controller::startWirelessControllerDiscoveryWithCompletionHandler(std::function<void ()> completionHandler)
    {
        [GCController startWirelessControllerDiscoveryWithCompletionHandler:^{
            completionHandler();
        }];
    }
    
    void Controller::stopWirelessControllerDiscovery()
    {
        [GCController stopWirelessControllerDiscovery];
    }
    
    bool Controller::isAttachedToDevice()
    {
        return [_controllerWrapper->controller isAttachedToDevice];
    }
    
    const char* Controller::getVendorName()
    {
        return [[_controllerWrapper->controller vendorName] cStringUsingEncoding:NSUTF8StringEncoding];
    }
    
    int Controller::getPlayerIndex()
    {
        return [_controllerWrapper->controller playerIndex];
    }
    
    void Controller::setControllerPausedHandler(std::function<void (Controller *controller) >handler)
    {
        _controllerPausedHandler = handler;
        _controllerWrapper->controller.controllerPausedHandler = ^(GCController *controller) {
            handler(this);
        };
    }
    
    void Controller::setControllerDidConnected(std::function<void ()> handler)
    {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserverForName:GCControllerDidConnectNotification
                            object:nil
                             queue:[NSOperationQueue mainQueue]
                        usingBlock:^(NSNotification *note) {
                            if (handler) handler();
                        }];
    }
    
    void Controller::setControllerDidDisconnected(std::function<void ()> handler)
    {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserverForName:GCControllerDidDisconnectNotification
                            object:nil
                             queue:[NSOperationQueue mainQueue]
                        usingBlock:^(NSNotification *note) {
                            if (handler) handler();
                        }];
    }
    
    Gamepad* Controller::getGamepad()
    {
        auto gamepad = new Gamepad();
        gamepad->_gamepadWrapper->gamepad = [_controllerWrapper->controller gamepad];
        gamepad->_controller = this;
        return gamepad;
    }
    
}
