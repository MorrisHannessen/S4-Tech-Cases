# Techcase 9

## Assignment

my assignment for this techcase was:

Create an app that shows the following parameters to the user:

- The percentage of charge of the battery of the device from 0% (empty battery) to 100% (fully charged).
- A graph, progress bar or other visualisation of the current charge of the battery with colours red, green and orange to represent different percentages.
- When your phone is charging: the number of minutes it takes to charge the battery.
- When your phone is not charging: the number of minutes left for the battery to be empty.
- The app must be for a global audience: The app can switch between a few languages and make sure that the UI adapts to the user's selection. One of the language that can be selected should be a right-to-left language like Arabic or Hebrew.

## Getting Started

1. Follow Flutter's getting started guide all the way up until you've got a working version of Flutter on the device of your choice.
2. Open a terminal in the working directory.
3. Run `flutter devices` to see the available devices. A device id should be visible the 2nd column.
4. Run flutter `run -d {DEVICE_ID}.`
5. Open the app on the device.
   Enjoy!

## Workflow

The first thing to do was setting up flutter and getting started. after that i got to work to the last requirements that was the language thing, because i thought if i setup this up from the start i don't need to change things later around.

After that i installed a plugin called batteryplus. After that it was fairly easy to make some functions for the "time left on device" and "time till fully charged" requirements

Here is my "time left on device" function. I looked up the average consumption for a device it i came to be a around 50mah to 150mah so i took the middle road. If i had more time i would have wrote a better function that would give a better estimation base on multiple battery drains. But i didn't use my device enough to even get it to under 50% and it was a bit to complicated for 3 weeks.
![](/documentation/img/Schermafbeelding%202024-03-10%20221501.png)

And here is my "time till fully charged" function. same for this function it is based on hardcoded stuff but there isn't a way to read this from the device so this is the best i could come up with in 3 weeks and its pretty accurate for my device.
![](/documentation/img/Schermafbeelding%202024-03-10%20222421.png)

## Design

There wasn't really a design requirement so the app looks fairly basic
![](/documentation/img/Schermafbeelding%202024-03-10%20223433.png)
