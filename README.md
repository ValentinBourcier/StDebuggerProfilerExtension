# Pharo debugger extension example 

This project contains:
- A debugger extension for profiling the call selected in the call stack.
- A template class to develop an extension for the Pharo debugger.

## How to install the project ?

To install the project run the following Metacello command:

```st
Metacello new
  githubUser: 'ValentinBourcier' project: 'StDebuggerProfilerExtension' commitish: 'main' path: 'src';
  baseline: 'StDebuggerProfilerExtension';
  load
```

## How to activate an extension ?

![activate-debugger-extension](https://github.com/ValentinBourcier/StDebuggerProfilerExtension/assets/32521673/e568a147-10d4-49fa-b6e2-4ebcda87d44c)  

From the debugger:  

1. Go to the settings browser (top right corner button).  
2. Find and click on the "Debugger Extensions" menu.  
3. Find and unfold your extension's menu.  
4. Tick the checkbox "Show in debugger".  

This can be also done by opening the settings browser from anywhere in the image.  
The "Debugger Extensions" menu is situated under the "Tools > Debugging" menu.

## How to create a new extension ?

Create a copy of the template class `StDebuggerExtensionTemplatePresenter`.

Pre-requisite:
1. The class must extend `SpPresenter`. Because the extension is going to be integrated into the debugger UI (made with Spec2).
2. The class must use the trait `TStDebuggerExtension`. To allow the system to detect it.
3. The name of the extension must unique. It must be declared by overriding the method `debuggerExtensionToolName` (inherited from the trait). Forgetting this will cause a failure when opening the settings browser.

Interesting to know:
- The instance variable `debugger` in the context of the extension represent the entire debugger UI (the instance of `StDebugger` in which the extension takes place).  

- Each update of the debugger UI triggers the update of the extension UI through the call of the message `updatePresenter` (from `SpPresenter`).
From there you can define the operations required for your extension to be in sync with the debugger context.
Notice that when the debugger open for the first time, `updatePresenter` is called at least 3 times.
During the debugger UI and the extension UI initialization, and after the first refresh of the call stack.



Tutorial to develop an Pharo debugger extension:  

- https://thepharo.dev/2021/04/02/debugger-extensions-in-pharo-9-0/

## Known issues

While developing an extension for the Pharo debugger, we might want to explore the content of the `debugger` variables.
Putting an `self halt` (sometimes even a `self haltOnce`) to observe the variable state during execution might not be possible.

It seems that the opening process of the debugger enters in a loop that the system kill at some point, resulting in no visible action or error.

A workaround is to add an `inspect` instruction such as `debugger inspect` instead of the `self halt`.
This will open an inspector for the debugger instance.





