# GCController Wrapper

iOS GameController.framework wrapper for C++

# Usage

```cpp
auto controller = iOSGamePad::Controller::controllers->at(0);
controller->getGamepad()->getButtonA()->setValueChangedHandler([&](iOSGamePad::ControllerButtonInput *, float, bool) {
  std::cout << "press button A!!!" << std::endl;
});
```
