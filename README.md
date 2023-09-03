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




