Beat per Minutes calculation
==========

Copyright 2012, Eng Eder de Souza

Matlab/Octave source for beat track calculation!

The approach used in this code are described by George Tzanetakis, 
the beat calculation is made breaking the signal in sub-band frequencies using DWT(Discrete wavelet transform),
After get all sub-bands we need envelope each band,
sum all Envelopes to a single onset strength signal and apply auto-correlation to find the peak position.

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Wavelets_-_Filter_Bank.png)](#features)\


Beat Examples in the folder [AudioTest] (https://github.com/ederwander/Beat-Track/tree/master/AudioTest)

How use:

        BPM=RunBPM('AudioTest/B128.wav')


Special thanks to George Tzanetakis who helped me at some points by email !

Eng Eder de Souza