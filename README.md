# OneHundredPrisoners

## Problem

There are 100 prisoners in solitary cells. There's a central living room with one light bulb; this bulb is initially off. No prisoner can see the light bulb from his or her own cell. Everyday, the warden picks a prisoner equally at random, and that prisoner visits the living room. While there, the prisoner can toggle the bulb if he or she wishes. Also, the prisoner has the option of asserting that all 100 prisoners have been to the living room by now. If this assertion is false, all 100 prisoners are shot. However, if it is indeed true, all prisoners are set free and inducted into MENSA, since the world could always use more smart people. Thus, the assertion should only be made if the prisoner is 100% certain of its validity. The prisoners are allowed to get together one night in the courtyard, to discuss a plan. What plan should they agree on, so that eventually, someone will make a correct assertion?

## Solution

The first prisoner selected is in charge of turning the light on whenever it is found off.
Each other prisoner is to turn the light off the very first time they find it on, otherwise they are to leave it in the state they found it. When the first prisoner selected turns the light on for the 100th time, they can safely assume that all prisoners have been in the interrogation room.

from: <https://medium.com/i-math/100-prisoners-and-a-light-bulb-573426272f4c>
