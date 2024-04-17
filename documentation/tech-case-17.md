# Techcase 17: Morse decoder

## Assignment

Create an app that offers the user to signal Morse code. The Morse code is translated into plain text and the text is shown on the screen. As a signal key you can use a simple button on the screen or an external hardware device.

Test the app with a HAM operator or find someone that really knows Morse code (we have some working at school that do).

## Getting Started

if you want to use the app you can follow this short guide on how to install the app on your device.

1. Follow Flutter's getting started guide all the way up until you've got a working version of Flutter on your pc
2. Open a terminal in the working directory. so in the root of the file in this case that is in the directory `../techcase-17`
3. run this command in the terminal: `run flutter`
4. Open the app on the device.
   Enjoy!

## Workflow

First of all, I started with the decoding Morse code part. I used the plugin [morse code translator](https://pub.dev/packages/morse_code_translator). In my first version, I just had an input field where you could type in your Morse code, and the app would decode it. However, after receiving feedback from Marcel:

<img src="/documentation/img/Feedpulse-1.png" alt="" width="700"/>

I came to the conclusion that I misunderstood the assignment.

So after that, I threw out my old input field and used a 'GestureDetector'. I made some changes on how the decoding worked, so you send it letter by letter. Using the GestureDetector, I could also implement a delete function, so if you swiped to the left, the last input was deleted. This made the app a lot more user-friendly.

<img src="/documentation/img/code-snipped-1.png" alt="" width="200"/>

As an extra feature, I made a function that will signal the Morse code you 'signaled' via the flashlight. I used a plugin called [torch](https://pub.dev/packages/torch_light). It wasn't very hard to make, but getting the timings right for the flashes is very hard. Due to the difference in devices, their flashlights, some devices weren't even fast enough to handle the fast toggles, so it would just seem like the flashlight was on all the time. But I think this is more of a Flutter problem in general than a device problem.

<img src="/documentation/img/code-snipped-2.png" alt="283" width="" height="318"/>

The app needed some styling and cleanup. So I added a background color and some basic button redesigning. And I added a manual on how to use the app. After that, I was ready to show it to Marcel for some feedback.

<img src="/documentation/img/Schermafbeelding 2024-04-17 135347.png" alt="" width="150" height="326"/>

Marcel was very positive and said this was more than enough for now. So I did a bit of cleanup, and in the screenshot above, here is how the app turned out.

<img src="/documentation/img/Feedpulse-2.png" alt="" width="700"/>
