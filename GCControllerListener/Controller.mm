//
//  GCController.cpp
//  HelloCpp
//
//  Created by giginet on 2014/1/13.
//
//

#include "Controller.h"
#import <GameController/GameController.h>

struct iOSGamePad::Controller::GCControllerStruct {
    GCController *controller;
};

iOSGamePad::Controller::Controller()
{
    _controllerWrapper = std::shared_ptr<GCControllerStruct>(new GCControllerStruct());
}

std::vector<iOSGamePad::Controller *> iOSGamePad::Controller::controllers()
{
    NSArray *controllers = [GCController controllers];
    std::vector<Controller *> vector;
    for (int i = 0; i < [controllers count]; ++i) {
        auto controller = new iOSGamePad::Controller();
        controller->_controllerWrapper->controller = controllers[i];
        vector.push_back(controller);
    }
    return vector;
}

void iOSGamePad::Controller::startWirelessControllerDiscoveryWithCompletionHandler(std::function<void ()> completionHandler)
{
    [GCController startWirelessControllerDiscoveryWithCompletionHandler:^{
        completionHandler();
    }];
}

void iOSGamePad::Controller::stopWirelessControllerDiscovery()
{
    [GCController stopWirelessControllerDiscovery];
}

bool iOSGamePad::Controller::isAttachedToDevice()
{
    return [_controllerWrapper->controller isAttachedToDevice];
}

const char* iOSGamePad::Controller::getVendorName()
{
    return [[_controllerWrapper->controller vendorName] cStringUsingEncoding:NSUTF8StringEncoding];
}

int iOSGamePad::Controller::getPlayerIndex()
{
    return [_controllerWrapper->controller playerIndex];
}

std::function<void (iOSGamePad::EventButtonInput *event)> iOSGamePad::Controller::getOnValueChangedHandler()
{
    return _onValueChangedHandler;
}

void iOSGamePad::Controller::setOnValueChangedHandler(std::function<void (EventButtonInput *)> handler)
{
    _onValueChangedHandler = handler;
    _controllerWrapper->controller.gamepad.valueChangedHandler = ^(GCGamepad *gamepad, GCControllerElement *element) {
        // ToDo attach event to each buttons
    };
}

std::function<void (iOSGamePad::Controller *controller)> iOSGamePad::Controller::getControllerPausedHandler()
{
    return _controllerPausedHandler;
}

void iOSGamePad::Controller::setControllerPausedHandler(std::function<void (Controller *controller) >handler)
{
    _controllerPausedHandler = handler;
    _controllerWrapper->controller.controllerPausedHandler = ^(GCController *controller) {
        handler(this);
    };
}

void iOSGamePad::Controller::setControllerDidConnected(std::function<void ()> handler)
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:GCControllerDidConnectNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        handler();
                    }];
}

void iOSGamePad::Controller::setControllerDidDisconnected(std::function<void ()> handler)
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:GCControllerDidDisconnectNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                        handler();
                    }];
}


