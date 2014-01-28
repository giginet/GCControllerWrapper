#include "HelloWorldScene.h"
#include "Controller.h"
#include "ControllerElement.h"
#include "Gamepad.h"

USING_NS_CC;

Scene* HelloWorld::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::create();
    
    // 'layer' is an autorelease object
    auto layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !Layer::init() )
    {
        return false;
    }
    
    Size visibleSize = Director::getInstance()->getVisibleSize();
    Point origin = Director::getInstance()->getVisibleOrigin();

    /////////////////////////////
    // 2. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    auto closeItem = MenuItemImage::create(
                                           "CloseNormal.png",
                                           "CloseSelected.png",
                                           CC_CALLBACK_1(HelloWorld::menuCloseCallback, this));
    
	closeItem->setPosition(Point(origin.x + visibleSize.width - closeItem->getContentSize().width/2 ,
                                origin.y + closeItem->getContentSize().height/2));

    // create menu, it's an autorelease object
    auto menu = Menu::create(closeItem, NULL);
    menu->setPosition(Point::ZERO);
    this->addChild(menu, 1);

    /////////////////////////////
    // 3. add your codes below...

    // add a label shows "Hello World"
    // create and initialize a label
    
    auto label = LabelTTF::create("Hello World", "Arial", 24);
    
    // position the label on the center of the screen
    label->setPosition(Point(origin.x + visibleSize.width/2,
                            origin.y + visibleSize.height - label->getContentSize().height));
    
    auto xAxis = LabelTTF::create("", "Arial", 24);
    xAxis->retain();
    _xAxisLabel = std::shared_ptr<LabelTTF>(xAxis);
    _xAxisLabel->setPosition(Point(300, 300));
    auto yAxis = LabelTTF::create("", "Arial", 24);
    yAxis->retain();
    _yAxisLabel = std::shared_ptr<LabelTTF>(yAxis);
    _yAxisLabel->setPosition(Point(300, 270));
    
    // add the label as a child to this layer
    this->addChild(label, 1);

    // add "HelloWorld" splash screen"
    auto sprite = Sprite::create("HelloWorld.png");

    // position the sprite on the center of the screen
    sprite->setPosition(Point(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));

    // add the sprite as a child to this layer
    this->addChild(sprite, 0);
    this->addChild(_xAxisLabel.get());
    this->addChild(_yAxisLabel.get());

    this->scheduleUpdate();
    
    return true;
}

void HelloWorld::update(float dt)
{
    auto controllers = iOSGamePad::Controller::controllers();
    if (controllers->size() > 0) {
        iOSGamePad::Controller* controller = controllers->at(0);
        controller->getGamepad()->getButtonA()->setValueChangedHandler([&](iOSGamePad::ControllerButtonInput *, float, bool) {
            std::cout << "press button A!!!" << std::endl;
        });
        float x = controller->getGamepad()->getDpad()->getXAxis()->getValue();
        float y = controller->getGamepad()->getDpad()->getYAxis()->getValue();
        _xAxisLabel->setString(std::to_string(x));
        _yAxisLabel->setString(std::to_string(y));
    } else {
        _xAxisLabel->setString("0");
        _yAxisLabel->setString("0");
    }
}


void HelloWorld::menuCloseCallback(Object* pSender)
{
    Director::getInstance()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
